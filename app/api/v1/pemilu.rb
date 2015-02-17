module Pemilu
  class APIv1 < Grape::API
    version 'v1', using: :accept_version_header
    prefix 'api'
    format :json

    resource :anggaran do
      desc "Return all Rekapitulasi Anggaran Tahapan Pemilu 2014"
      get do
        rekapitulasi = Array.new

        # Prepare conditions based on params
        valid_params = {
          keterangan: 'keterangan'
        }

        conditions = Hash.new
        valid_params.each_pair do |key, value|
          conditions[value.to_sym] = params[key.to_sym] unless params[key.to_sym].blank?
        end

        # Set default type
        conditions[:tipe] = params[:tipe] || 'provinsi'

        # Set default limit
        limit = (params[:limit].to_i == 0 || params[:limit].empty?) ? 34 : params[:limit]

        Anggaran.where(conditions)
          .limit(limit)
          .offset(params[:offset])
          .each do |rekap|

            rekapitulasi << {
                id: rekap.id,
                keterangan: rekap.keterangan,
                pagu: rekap.pagu,
                realisasi: rekap.realisasi,
                sisa: rekap.sisa,
                presentase: rekap.presentase
            }

        end

        {
          results: {
            count: rekapitulasi.count,
            total: Anggaran.where(conditions).count,
            data: rekapitulasi
          }
        }
      end
    end
  end
end