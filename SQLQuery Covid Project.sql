select * 
from coviddeath order by 3,4

select *
from covidVaccinations order by 3,4

select location, date, total_cases, new_cases, total_deaths, population
from coviddeath
order by 1,2

-- Looking at Total Cases VS Total Deaths
-- Shows likelihood of dying in India

select location, date, total_cases, total_deaths,cast(total_deaths as float)/cast(total_cases as float)*100 as DeathPercentage
from coviddeath
where location like 'India'
order by 1,2

-- Looking at Total Cases VS Population

select location, date, total_cases, population, (total_cases/ population)*100 as DeathPercentage
from coviddeath
where location like 'India'
order by 1,2

-- Looking at countries with Highest Infected Rate compared to Popluation

select location, population, MAX(total_cases) as HighestInfected, MAX(total_cases/population)*100 as PercentagePopulation
from coviddeath where continent is not null
Group by location, population
order by PercentagePopulation desc

-- Showing the countries with Highest Death Rate per Population

select location, MAX(cast(total_deaths as int)) as TotalDeathCount
from coviddeath where continent is not null
group by location
order by TotalDeathCount Desc

-- Breaking things Down by Continent

select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
from coviddeath where continent is not null
group by continent
order by TotalDeathCount Desc

-- Showing the continent with highest Death Count

select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
from coviddeath
where continent is not null
group by continent
order by TotalDeathCount desc


-- Breaking Global Numbers


select date, sum(new_cases)as total_cases,sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from coviddeath
where continent is not null
group by date
order by 1,2



Select * from covidVaccinations

-- Joining the tables

select * from coviddeath dea
join covidVaccinations vac
on dea.location = vac.location 
and dea.date=vac.date

-- Looking at Total Population VS Vaccination

select dea.continent, dea.location, dea.date,dea.population, vac.new_vaccinations,
SUM(CONVERT(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
from coviddeath dea
join covidVaccinations vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null
order by 2,3

-- Creating view to store data for later visualization

Create view PercentagePopulationVaccinated as
select dea.continent, dea.location, dea.date,dea.population, vac.new_vaccinations,
SUM(CONVERT(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
from coviddeath dea
join covidVaccinations vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null

select * from PercentagePopulationVaccinated






