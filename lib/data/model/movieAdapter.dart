part of 'movieDetails_data.dart';

class DetailsAdapter extends TypeAdapter<DetailsModel> {
  @override
  DetailsModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DetailsModel(
     Title: fields[0] as String,
      Id: fields[1] as num,
      BackdropPath: fields[2] as String,
      ReleaseDate: fields[3] as String,
      PosterPath: fields[4] as String,
      Overview: fields[5] as String,
      VoteAverage: fields[6] as num
    );
  }

  @override
  void write(BinaryWriter writer, DetailsModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.Title)
      ..writeByte(1)
      ..write(obj.Id)
      ..writeByte(2)
      ..write(obj.BackdropPath)
      ..writeByte(3)
      ..write(obj.ReleaseDate)
      ..writeByte(4)
      ..write(obj.PosterPath)
      ..writeByte(5)
      ..write(obj.Overview)
      ..writeByte(6)
      ..write(obj.VoteAverage);
  }
}
