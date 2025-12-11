import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class Photo_picker extends StatelessWidget {
  const Photo_picker({
    super.key, required this.onTap, this.selectedPhoto,
  });

  final VoidCallback onTap;
  final XFile ? selectedPhoto;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5)
        ),
        child: Row(
          children: [
            Container(
              child: Text('Photo',
                style: TextStyle(color: Colors.white),
              ),
              alignment: Alignment.center,
              width: 80,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  )
              ),
            ),
            Expanded(
              child: Text(selectedPhoto == null ? "No photo selected" : selectedPhoto!.name,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}