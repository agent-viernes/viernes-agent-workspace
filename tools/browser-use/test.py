from browser_use import Agent, Browser, ChatBrowserUse
import asyncio

async def example():
    browser = Browser()
    llm = ChatBrowserUse()
    
    agent = Agent(
        task="Ve a mercadolibre.com.co y busca kawasaki versys",
        llm=llm,
        browser=browser,
    )
    
    history = await agent.run()
    return history

if __name__ == "__main__":
    history = asyncio.run(example())
