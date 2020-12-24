import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

WikiData wikiDataFromJson(String str) => WikiData.fromJson(json.decode(str));

String wikiDataToJson(WikiData data) => json.encode(data.toJson());

//part 'wiki_data.g.dart';

@JsonSerializable(nullable: false)
class WikiData {
    WikiData({
        this.batchcomplete,
        this.wikiDataContinue,
        this.query,
    });

    bool batchcomplete;
    Continue wikiDataContinue;
    Query query;

    factory WikiData.fromJson(Map<String, dynamic> json) => WikiData(
        batchcomplete: json["batchcomplete"],
        wikiDataContinue: Continue.fromJson(json["continue"]),
        query: Query.fromJson(json["query"]),
    );

    Map<String, dynamic> toJson() => {
        "batchcomplete": batchcomplete,
        "continue": wikiDataContinue.toJson(),
        "query": query.toJson(),
    };
}

class Query {
    Query({
        this.redirects,
        this.pages,
    });

    List<Redirect> redirects;
    List<Pages> pages;

    factory Query.fromJson(Map<String, dynamic> json) => Query(
        redirects: List<Redirect>.from(json["redirects"].map((x) => Redirect.fromJson(x))),
        pages: List<Pages>.from(json["pages"].map((x) => Pages.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "redirects": List<dynamic>.from(redirects.map((x) => x.toJson())),
        "pages": List<dynamic>.from(pages.map((x) => x.toJson())),
    };
}

class Pages {
    Pages({
        this.pageid,
        this.ns,
        this.title,
        this.index,
        this.thumbnail,
        this.terms,
    });

    int pageid;
    int ns;
    String title;
    int index;
    Thumbnail thumbnail;
    Terms terms;

    factory Pages.fromJson(Map<String, dynamic> json) => Pages(
        pageid: json["pageid"],
        ns: json["ns"],
        title: json["title"],
        index: json["index"],
        thumbnail: json["thumbnail"] == null ? null : Thumbnail.fromJson(json["thumbnail"]),
        terms: json["terms"] == null ? null : Terms.fromJson(json["terms"]),
    );

    Map<String, dynamic> toJson() => {
        "pageid": pageid,
        "ns": ns,
        "title": title,
        "index": index,
        "thumbnail": thumbnail == null ? null : thumbnail.toJson(),
        "terms": terms == null ? null : terms.toJson(),
    };
}

class Terms {
    Terms({
        this.description,
    });

    List<String> description;

    factory Terms.fromJson(Map<String, dynamic> json) => Terms(
        description: List<String>.from(json["description"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "description": List<dynamic>.from(description.map((x) => x)),
    };
}

class Thumbnail {
    Thumbnail({
        this.source,
        this.width,
        this.height,
    });

    String source;
    int width;
    int height;

    factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        source: json["source"],
        width: json["width"],
        height: json["height"],
    );

    Map<String, dynamic> toJson() => {
        "source": source,
        "width": width,
        "height": height,
    };
}

class Redirect {
    Redirect({
        this.index,
        this.from,
        this.to,
    });

    int index;
    String from;
    String to;

    factory Redirect.fromJson(Map<String, dynamic> json) => Redirect(
        index: json["index"],
        from: json["from"],
        to: json["to"],
    );

    Map<String, dynamic> toJson() => {
        "index": index,
        "from": from,
        "to": to,
    };
}

class Continue {
    Continue({
        this.gpsoffset,
        this.continueContinue,
    });

    int gpsoffset;
    String continueContinue;

    factory Continue.fromJson(Map<String, dynamic> json) => Continue(
        gpsoffset: json["gpsoffset"],
        continueContinue: json["continue"],
    );

    Map<String, dynamic> toJson() => {
        "gpsoffset": gpsoffset,
        "continue": continueContinue,
    };
}
