CREATE TYPE kategori_triase_enum AS ENUM (
    'Merah',
    'Kuning',
    'Hijau',
    'Hitam'
);

CREATE TABLE pendaftaran (
    pendaftaran_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    no_rm VARCHAR(32) NOT NULL,
    nik_anonim VARCHAR(128) NOT NULL,
    waktu_kedatangan TIMESTAMPTZ NOT NULL,

    CONSTRAINT uq_pendaftaran_no_rm UNIQUE (no_rm)
);

COMMENT ON COLUMN pendaftaran.pendaftaran_id IS 'ID unik untuk setiap pendaftaran IGD.';
COMMENT ON COLUMN pendaftaran.no_rm IS 'Nomor rekam medis pasien.';
COMMENT ON COLUMN pendaftaran.nik_anonim IS 'Identitas NIK yang telah dianonimkan atau dipseudonimkan; bukan NIK asli.';
COMMENT ON COLUMN pendaftaran.waktu_kedatangan IS 'Waktu kedatangan pasien di IGD, termasuk zona waktu.';

CREATE TABLE triase_igd (
    triase_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    pendaftaran_id BIGINT NOT NULL,
    kategori_triase kategori_triase_enum NOT NULL,
    keluhan_utama TEXT NOT NULL,
    sistol SMALLINT,
    diastol SMALLINT,
    nadi SMALLINT,
    suhu NUMERIC(4, 1),
    rr SMALLINT,
    spo2 SMALLINT,

    CONSTRAINT fk_triase_pendaftaran
        FOREIGN KEY (pendaftaran_id)
        REFERENCES pendaftaran (pendaftaran_id),

    CONSTRAINT chk_triase_sistol CHECK (sistol IS NULL OR sistol > 0),
    CONSTRAINT chk_triase_diastol CHECK (diastol IS NULL OR diastol > 0),
    CONSTRAINT chk_triase_nadi CHECK (nadi IS NULL OR nadi > 0),
    CONSTRAINT chk_triase_suhu CHECK (suhu IS NULL OR suhu > 0),
    CONSTRAINT chk_triase_rr CHECK (rr IS NULL OR rr > 0),
    CONSTRAINT chk_triase_spo2 CHECK (spo2 IS NULL OR spo2 BETWEEN 0 AND 100)
);

COMMENT ON COLUMN triase_igd.triase_id IS 'ID unik untuk setiap catatan triase.';
COMMENT ON COLUMN triase_igd.pendaftaran_id IS 'Referensi ke pendaftaran IGD pasien.';
COMMENT ON COLUMN triase_igd.kategori_triase IS 'Kategori triase: Merah, Kuning, Hijau, atau Hitam.';
COMMENT ON COLUMN triase_igd.keluhan_utama IS 'Keluhan utama pasien saat menjalani triase.';
COMMENT ON COLUMN triase_igd.sistol IS 'Tekanan darah sistolik dalam mmHg.';
COMMENT ON COLUMN triase_igd.diastol IS 'Tekanan darah diastolik dalam mmHg.';
COMMENT ON COLUMN triase_igd.nadi IS 'Frekuensi nadi dalam denyut per menit.';
COMMENT ON COLUMN triase_igd.suhu IS 'Suhu tubuh dalam derajat Celsius.';
COMMENT ON COLUMN triase_igd.rr IS 'Frekuensi pernapasan dalam napas per menit.';
COMMENT ON COLUMN triase_igd.spo2 IS 'Saturasi oksigen perifer dalam persen.';
