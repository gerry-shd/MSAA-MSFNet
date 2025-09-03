from ultralytics import YOLO

model = YOLO("runs_cones/YOLOv11_all/exp/weights/best.pt")  # 替换为你自己的模型路径

# 导出为ONNX格式
model.export(format='onnx')  # 'dynamic=True' 会支持动态大小输入