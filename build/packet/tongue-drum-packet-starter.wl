(* Compatibility copy of the TNG-001 V5 source-only gate stub.

   This file intentionally contains no tuning constants, target frequencies,
   measured frequencies, CAD dimensions, or computed geometry. It has not been
   executed. Keep in sync with wolfram-starter.wl until the packet chooses one
   canonical Wolfram entrypoint. *)

ClearAll["Global`*"];

packetStatus = <|
  "InstrumentID" -> "TNG-001",
  "Readiness" -> "L2 V5 build-packet candidate",
  "Authority" -> "concept_only",
  "GeometryAuthority" -> "pending_measurement",
  "TuningAuthority" -> "pending_measurement",
  "RuntimeStatus" -> "source_only_not_executed"
|>;

requiredInputs = {
  "reviewed_cad_configuration",
  "measured_or_reviewed_dimension_table",
  "material_batch_record",
  "cnc_coupon_results",
  "strike_measurement_protocol",
  "as_cut_strike_log",
  "post_trim_strike_log"
};

missingInputQ[input_] := True;

packetStatus
