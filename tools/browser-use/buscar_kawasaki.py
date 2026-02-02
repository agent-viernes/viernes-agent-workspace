from browser_use import Agent, Browser, ChatBrowserUse, BrowserProfile
import asyncio
import os

async def buscar_kawasaki():
    # Configurar API key de Browser Use
    os.environ['BROWSER_USE_API_KEY'] = 'bu_96VkWF8jXADaRImFLUVwXMevnpvShq-OTD6Md45L6F0'
    
    # Usar el modelo optimizado de Browser Use
    llm = ChatBrowserUse()
    
    # Configurar navegador para headless
    profile = BrowserProfile(
        headless=True,
        args=['--no-sandbox', '--disable-dev-shm-usage'],
        chromium_sandbox=False
    )
    browser = Browser(browser_profile=profile)
    
    agent = Agent(
        task="Ve a mercadolibre.com.co, busca 'kawasaki versys', y extrae los primeros 3 resultados con: título, precio, año, kilometraje y ubicación.",
        llm=llm,
        browser=browser,
    )
    
    history = await agent.run()
    return history

if __name__ == "__main__":
    result = asyncio.run(buscar_kawasaki())
    print(result)
