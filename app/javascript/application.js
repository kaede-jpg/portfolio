// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import { fas } from '@fortawesome/free-solid-svg-icons'
import { far } from '@fortawesome/free-regular-svg-icons'
import { fab } from '@fortawesome/free-brands-svg-icons'
import { library } from "@fortawesome/fontawesome-svg-core";
import '@fortawesome/fontawesome-free'
library.add(fas, far, fab)

document.addEventListener('turbo:load', () => {
    const loader = document.querySelector('.loader');
    const new_record_loader = document.querySelector('.new_record_loader');
    const btn = document.querySelector('.new_record_btn');
  
    window.addEventListener('load', () => {
      loader.style.display = 'none'; 
    });
  
    setTimeout(() => {
      loader.style.display = 'none'; 
    }, 2000);

    if (new_record_loader && btn) {
        btn.addEventListener('click', () => {
            new_record_loader.style.display = 'flex'; 
        });

        window.addEventListener('load', () => {
            new_record_loader.style.display = 'none'; 
        });
        
        setTimeout(() => {
            new_record_loader.style.display = 'none'; 
        }, 2000);
    };
  });

document.addEventListener('turbo:load', () => {
    const buttons = document.querySelectorAll('.hide_btn'); 
    const stamps = document.querySelectorAll('.stamps'); 

    buttons.forEach((button, index) => {
        button.addEventListener('click', () => {
            const stamp = stamps[index];
            if (stamp.style.display === 'none') {
                stamp.style.display = 'grid';
                button.textContent = 'スタンプを隠す';
            } else {
                stamp.style.display = 'none';
                button.textContent = 'スタンプを表示';
            }
        });
    });
});