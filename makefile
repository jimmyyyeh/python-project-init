project:
	@read -p "請輸入專案完整路徑: " folder_name; \
	parent_dir=$$(dirname $$folder_name); \
	if [ ! -d $$parent_dir ]; then \
		echo "父目錄不存在: $$parent_dir"; \
		echo "請先創建該目錄或檢查路徑是否正確"; \
		exit 1; \
	fi; \
	if [ -d $$folder_name ]; then \
		echo "資料夾已存在: $$folder_name"; \
		echo "請重新執行並選擇不同名稱"; \
		exit 1; \
	fi; \
	mkdir $$folder_name; \
	cp -r . $$folder_name/; \
	sed -i '' "s|{project-name}|$$(basename $$folder_name)|g" $$folder_name/docker-compose.yaml; \
	touch $$folder_name/README.md; \
	cd $$folder_name && \
	poetry init --no-interaction --name $$(basename $$folder_name) --author "Jimmy Yeh <chienfeng0719@hotmail.com>" && \
	poetry install --no-root && \
	echo "[INFO] 專案初始化完成！"

