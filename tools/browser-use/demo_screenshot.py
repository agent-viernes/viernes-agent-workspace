from browser_use import Agent, Browser, ChatBrowserUse
import asyncio
import os

async def demo_screenshot():
    os.environ['BROWSER_USE_API_KEY'] = 'bu_96VkWF8jXADaRImFLUVwXMevnpvShq-OTD6Md45L6F0'
    
    llm = ChatBrowserUse()
    browser = Browser(use_cloud=True)
    
    agent = Agent(
        task="Ve a google.com, busca 'kawasaki versys 650' y toma un screenshot de los resultados",
        llm=llm,
        browser=browser,
    )
    
    history = await agent.run()
    
    # El screenshot se guarda automáticamente en el historial
    for action in history:
        if hasattr(action, 'screenshot'):
            print(f"Screenshot guardado")
    
    return history

if __name__ == "__main__":
    asyncio.run(demo_screenshot())
