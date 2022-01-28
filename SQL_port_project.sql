select * from CovidDeaths
where continent is not null
order by 3,4

select * from CovidVaccinations
order by location,date

---select the data we will be using
select location, date, population, total_cases, new_cases, total_deaths 
from CovidDeaths
order by location,date

-- Total cases vs total deaths
select location, date, total_cases, total_deaths, (total_deaths/total_cases)* 100  as deathPercent 
from CovidDeaths
where location like '%Ghana%'
order by location,date 

-- Total cases vs Population
-- Percentage of population who got covid
select location, date, population, total_cases, (total_cases/population)* 100  as infectionPercent 
from CovidDeaths
where location = 'Norway'
order by location,date 

--Countries with highest infection rate
select location,population, max(total_cases) as HighestInfection, max((total_cases/population))* 100  as MaxInfectionPercent 
from CovidDeaths
--where location = 'Norway'
group by location,population
order by MaxInfectionPercent desc

select * from CovidDeaths

-- Countries with the highest death count per country
select location, continent, max(cast(total_deaths as int)) as HighestDeathsCount
from CovidDeaths
where continent is not null
group by location,continent
order by HighestDeathsCount desc

--Breaking things down by continent
select location, max(cast(total_deaths as int)) as HighestDeathsCount
from CovidDeaths
where continent is null
group by location
order by HighestDeathsCount desc

select continent, max(cast(total_deaths as int)) as HighestDeathsCount
from CovidDeaths
where continent is not null
group by continent
order by HighestDeathsCount desc

--continents with highest death counts per population
select continent, max(cast(total_deaths as int)) as HighestDeathsCount
from CovidDeaths
where continent is not null
group by continent
order by HighestDeathsCount desc

--Global numbers
select sum(new_cases) as TotalNewCasesperDay, sum(cast(new_deaths as int)) as TotalNewDeaths,
sum(cast(new_deaths as int)) / sum(new_cases) *100 as DeathPercentPerNewCases
from CovidDeaths
--where location = 'Norway'
where continent is not null
--group by date
order by DeathPercentPerNewCases desc

--Vaccination table
select * from CovidVaccinations

alter table CovidVaccinations
drop column new_tests_per_thousand


select * from CovidDeaths
select * from CovidVaccinations


-- Joining the two tables together
select * 
from CovidDeaths dea   --dea is an alias name 
join CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date

-- Total population vs vaccination
select dea.continent, dea.location, dea.date, dea.population,  --If you join both tables u can select colums from both at the same time
vac.new_vaccinations
from CovidDeaths dea   --dea is an alias name 
join CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null ---and vac.new_vaccinations is not null
order by continent, location, date

-- Sum up vaccination per location
select dea.continent, dea.location, dea.date, dea.population,  --If you join both tables u can select colums from both at the same time
vac.new_vaccinations, sum(cast(vac.new_vaccinations as int)) over 
(partition by dea.location order by dea.location, dea.date) as TotalNewVacc
from CovidDeaths dea   --dea is an alias name 
join CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null ---and vac.new_vaccinations is not null
order by location, date

--Using the newly created variable TotalNewVacc in calculation
with PopvsVac(continent, location, date, population,new_vaccinations, TotalNewVacc)
as
(
select dea.continent, dea.location, dea.date, dea.population,  --If you join both tables u can select colums from both at the same time
vac.new_vaccinations, sum(cast(vac.new_vaccinations as int)) over 
(partition by dea.location order by dea.location, dea.date) as TotalNewVacc
from CovidDeaths dea   --dea is an alias name 
join CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null ---and vac.new_vaccinations is not null
--order by location, date
)

select *, (TotalNewVacc/population) * 100 as Percent_Vacc_per_population
from PopvsVac
--where location='Ghana'

--creating view to store for later visualization
create view 