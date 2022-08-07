#include "GetStudentAllCourses.h"

void GetStudentAllCourses(Json::Value &requestJson, Json::Value &response, drogon::orm::DbClient &dbClient)
{
    std::clog << "Get \"student-all-courses\" request" << std::endl;

    std::ifstream inputFileStream("../../../sql/get-student-all-courses.sql");
    std::stringstream queryStream;

    queryStream << inputFileStream.rdbuf();

    std::shared_future<drogon::orm::Result> resultFuture = dbClient.execSqlAsyncFuture(queryStream.str(), requestJson["user_id"].asInt64());

    resultFuture.wait();

    drogon::orm::Result result = resultFuture.get();

    std::clog << "Making response" << std::endl;

    for(long i = 0; i < result.size(); ++i)
    {
        Json::Value responseRow;

        responseRow["course_id"] = result[i]["COURSE_ID"].as<Json::Int64>();
        responseRow["title"] = result[i]["TITLE"].as<Json::String>();
        responseRow["description"] = result[i]["DESCRIPTION"].as<Json::String>();
        responseRow["price"] = result[i]["PRICE"].as<Json::Int64>();
        responseRow["rate"] = result[i]["RATE"].as<double>();
        responseRow["number_of_enrolls"] = result[i]["NUMBER_OF_ENROLLS"].as<Json::Int64>();

        response["query_user_courses"].append(responseRow);
    }

    response["ok"] = true;

    inputFileStream.close();
}