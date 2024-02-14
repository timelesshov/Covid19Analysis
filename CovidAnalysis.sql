--SELECT
--    Location,
--    date,
--    total_cases,
--    new_cases,
--    total_deaths,
--    population
--FROM
--    CovidDeaths
--ORDER BY 1,2;
--SELECT
--    Location,
--    date,
--    total_cases,
--    new_cases,
--    total_deaths,
--    population,
--    CAST(total_deaths AS FLOAT) / total_cases * 100 AS DeathCaseRatio_Percentage
--FROM
--    CovidDeaths
--ORDER BY
--    1, 2;
-- Countries with highest infection rate compared to population
--WITH InfectionRate AS (
--    SELECT
--        Location,
--        MAX(CAST(total_cases AS FLOAT)) AS total_cases,
--        MAX(CAST(population AS FLOAT)) AS population,
--        MAX(CAST(total_cases AS FLOAT)) * 100.0 / MAX(CAST(population AS FLOAT)) AS infection_rate
--    FROM
--        CovidDeaths
--    GROUP BY
--        Location
--)
--SELECT
--    Location,
--    total_cases,
--    population,
--    infection_rate
--FROM
--    InfectionRate
--ORDER BY
--    infection_rate DESC;
-- Countries with highest death count per population
--WITH DeathRate AS (
--    SELECT
--        Location,
--        MAX(CAST(total_deaths AS FLOAT)) AS total_deaths,
--        MAX(CAST(population AS FLOAT)) AS population,
--        CASE 
--            WHEN MAX(CAST(population AS FLOAT)) > 0 THEN 
--                MAX(CAST(total_deaths AS FLOAT)) * 100.0 / MAX(CAST(population AS FLOAT)) 
--            ELSE 
--                NULL 
--        END AS death_rate_per_capita
--    FROM
--        CovidDeaths
--    GROUP BY
--        Location
--)
--SELECT
--    Location,
--    total_deaths,
--    population,
--    death_rate_per_capita
--FROM
--    DeathRate
--ORDER BY
--    death_rate_per_capita DESC;




-- SHOWING CONTINENTS WITH HIGHEST DEATH COUNT
--SELECT 
--    continent,
--    MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
--FROM 
--    CovidDeaths
--WHERE 
--    continent IS NOT NULL
--GROUP BY 
--    continent
--ORDER BY 
--    TotalDeathCount DESC;
--SELECT *
--FROM CovidDeaths d
--JOIN CovidVacinations v ON d.location = v.location AND d.date = v.date;
--SELECT d.continent, 
--       d.location, 
--       d.date, 
--       d.population, 
--       v.new_vaccinations, 
--       SUM(CAST(v.new_vaccinations AS bigint)) OVER (PARTITION BY d.location ORDER BY d.location, d.date) AS total_vaccinations
--FROM CovidDeaths d
--JOIN CovidVacinations v ON d.location = v.location AND d.date = v.date
--WHERE d.continent IS NOT NULL
--ORDER BY 2, 3;
--WITH VaccinationSummary AS (
--    SELECT 
--        d.location, 
--        SUM(CAST(v.new_vaccinations AS bigint)) AS total_vaccinations,
--        d.population
--    FROM CovidDeaths d
--    JOIN CovidVacinations v ON d.location = v.location AND d.date = v.date
--    WHERE d.continent IS NOT NULL
--    GROUP BY d.location, d.population
--)
--SELECT 
--    d.continent, 
--    d.location, 
--    d.date, 
--    d.population, 
--    v.new_vaccinations, 
--    vs.total_vaccinations,
--    (CAST(vs.total_vaccinations AS float) / d.population) * 100 AS VaccinatedPopulationRatio
--FROM 
--    CovidDeaths d
--JOIN 
--    CovidVacinations v ON d.location = v.location AND d.date = v.date
--JOIN 
--    VaccinationSummary vs ON d.location = vs.location
--ORDER BY 
--    d.location, 
--    d.date;

--SELECT d.continent, 
--       d.location, 
--       d.date, 
--       d.population, 
--       v.new_vaccinations, 
--       SUM(CAST(v.new_vaccinations AS bigint)) OVER (PARTITION BY d.location ORDER BY d.location, d.date) AS total_vaccinations,
--       (CAST(SUM(CAST(v.new_vaccinations AS bigint)) OVER (PARTITION BY d.location ORDER BY d.location, d.date) AS float) / d.population) * 100 AS VaccinatedPopulationRatio
--FROM CovidDeaths d
--JOIN CovidVacinations v ON d.location = v.location AND d.date = v.date
--WHERE d.continent IS NOT NULL
--ORDER BY 2, 3;

--SELECT d.continent, 
--       d.location, 
--       d.date, 
--       d.population, 
--       v.new_vaccinations, 
--       SUM(COALESCE(CAST(v.new_vaccinations AS bigint), 0)) OVER (PARTITION BY d.location ORDER BY d.location, d.date) AS total_vaccinations,
--       (CAST(SUM(COALESCE(CAST(v.new_vaccinations AS bigint), 0)) OVER (PARTITION BY d.location ORDER BY d.location, d.date) AS float) / NULLIF(d.population, 0)) * 100 AS VaccinatedPopulationRatio
--INTO #PercentPopulationVacc
--FROM CovidDeaths d
--JOIN CovidVacinations v ON d.location = v.location AND d.date = v.date
--WHERE d.continent IS NOT NULL
--ORDER BY 2, 3;

-- Display contents of the temp table
--SELECT * FROM #PercentPopulationVaccinated;
--IF OBJECT_ID('tempdb..#PercentPopulationVaccinated') IS NOT NULL
--    DROP TABLE #PercentPopulationVaccinated;

--SELECT d.continent, 
--       d.location, 
--       d.date, 
--       d.population, 
--       v.new_vaccinations, 
--       SUM(CAST(v.new_vaccinations AS bigint)) OVER (PARTITION BY d.location ORDER BY d.location, d.date) AS total_vaccinations,
--       (CAST(SUM(CAST(v.new_vaccinations AS bigint)) OVER (PARTITION BY d.location ORDER BY d.location, d.date) AS float) / d.population) * 100 AS VaccinatedPopulationRatio
--INTO #PercentPopulationVaccinated
--FROM CovidDeaths d
--JOIN CovidVacinations v ON d.location = v.location AND d.date = v.date
--WHERE d.continent IS NOT NULL
--ORDER BY 2, 3;

--IF OBJECT_ID('tempdb..#LaTempie') IS NOT NULL
--    DROP TABLE #LaTempie;

--SELECT d.continent, 
--       d.location, 
--       d.date, 
--       d.population, 
--       v.new_vaccinations, 
--       SUM(CAST(v.new_vaccinations AS bigint)) OVER (PARTITION BY d.location ORDER BY d.location, d.date) AS total_vaccinations,
--       (CAST(SUM(CAST(v.new_vaccinations AS bigint)) OVER (PARTITION BY d.location ORDER BY d.location, d.date) AS float) / d.population) * 100 AS VaccinatedPopulationRatio
--INTO #LaTempie
--FROM CovidDeaths d
--JOIN CovidVacinations v ON d.location = v.location AND d.date = v.date
--WHERE d.continent IS NOT NULL
--ORDER BY 2, 3;

--SELECT * FROM #LaTempie;

--CREATE VIEW PercentPopulationVaccinated AS
--SELECT d.continent, 
--       d.location, 
--       d.date, 
--       d.population, 
--       v.new_vaccinations, 
--       SUM(CAST(v.new_vaccinations AS bigint)) OVER (PARTITION BY d.location ORDER BY d.location, d.date) AS total_vaccinations,
--       (CAST(SUM(CAST(v.new_vaccinations AS bigint)) OVER (PARTITION BY d.location ORDER BY d.location, d.date) AS float) / d.population) * 100 AS VaccinatedPopulationRatio
--FROM CovidDeaths d
--JOIN CovidVacinations v ON d.location = v.location AND d.date = v.date
--WHERE d.continent IS NOT NULL;

SELECT * FROM PercentPopulationVaccinated;













