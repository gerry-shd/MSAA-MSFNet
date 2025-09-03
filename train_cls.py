import warnings

warnings.filterwarnings('ignore')
from ultralytics import YOLO

model_path = "ultralytics/cfg/models/11_cls_msaa_v2/sv2_bifpn_msaa_sv2_05.yaml"
dataset_path = "/home/wangf/object_projects/other_datasets/paper_datasets/sonar_cls_dataset_split/images"

yolov11_model = YOLO(model_path, task="classify")
yolov11_model.train(data=dataset_path,
                 cache=True,
                 imgsz=224,
                 epochs=100,
                 single_cls=False,  # 是否是单类别检测
                 batch=64,
                 close_mosaic=10,
                 workers=0,
                 device='0,1,2,3',
                 # optimizer='SGD',  # using SGD
                 optimizer='Adam',  # using SGD
                 # resume='', # 如过想续训就设置last.pt的地址
                 amp=True,  # 如果出现训练损失为Nan可以关闭amp
                 project=f'runs/train_yolo_cls',
                 name='sonar')
