From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: __user with scalar data types
Date: Tue, 20 Jun 2017 09:42:01 +0200
Message-ID: <1497944521.16795.2.camel@redhat.com>
References: <20170619161509.GA25997@jcrouse-lnx.qualcomm.com>
 <20170619163438.GE10672@ZenIV.linux.org.uk>
 <CAKMK7uFdH4VBftjyVCbXqcu76qMTSvkVFRDB3tJtX3N+SNm72w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-6YXy54cSZh9okyFnXdLl"
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAKMK7uFdH4VBftjyVCbXqcu76qMTSvkVFRDB3tJtX3N+SNm72w@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel@ffwll.ch>, Al Viro <viro@zeniv.linux.org.uk>, "Clark, Rob" <robdclark@gmail.com>
Cc: linux-sparse@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>
List-Id: linux-sparse@vger.kernel.org


--=-6YXy54cSZh9okyFnXdLl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

  Hi,

> Yep that's cargo-culted, but from a quick grep only msm and qxl
> headers do this (the other __user annotations in uapi/drm are for
> pointers, where it's correct). Adding those maintainers.

Yep, those looks pointless indeed.

> Also, if you use u64_to_user_ptr helper macro sparse should have
> caught this (if not we'd need to improve the macro).

And qxl should actually use it.

Fix attached (compile-tested only so far), does that look ok?

cheers,
  Gerd
--=-6YXy54cSZh9okyFnXdLl
Content-Type: text/x-patch; name="qxlfix"; charset="UTF-8"
Content-Description: 
Content-Disposition: inline; filename="qxlfix"
Content-Transfer-Encoding: 7bit

diff --git a/include/uapi/drm/qxl_drm.h b/include/uapi/drm/qxl_drm.h
index 7eef422130..880999d2d8 100644
--- a/include/uapi/drm/qxl_drm.h
+++ b/include/uapi/drm/qxl_drm.h
@@ -80,8 +80,8 @@ struct drm_qxl_reloc {
 };
 
 struct drm_qxl_command {
-	__u64	 __user command; /* void* */
-	__u64	 __user relocs; /* struct drm_qxl_reloc* */
+	__u64		command; /* void* */
+	__u64		relocs; /* struct drm_qxl_reloc* */
 	__u32		type;
 	__u32		command_size;
 	__u32		relocs_num;
@@ -91,7 +91,7 @@ struct drm_qxl_command {
 struct drm_qxl_execbuffer {
 	__u32		flags;		/* for future use */
 	__u32		commands_num;
-	__u64	 __user commands;	/* struct drm_qxl_command* */
+	__u64		commands;	/* struct drm_qxl_command* */
 };
 
 struct drm_qxl_update_area {
diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index 0b82a87916..31effed4a3 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -163,7 +163,7 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 		return -EINVAL;
 
 	if (!access_ok(VERIFY_READ,
-		       (void *)(unsigned long)cmd->command,
+		       u64_to_user_ptr(cmd->command),
 		       cmd->command_size))
 		return -EFAULT;
 
@@ -183,7 +183,9 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 
 	/* TODO copy slow path code from i915 */
 	fb_cmd = qxl_bo_kmap_atomic_page(qdev, cmd_bo, (release->release_offset & PAGE_SIZE));
-	unwritten = __copy_from_user_inatomic_nocache(fb_cmd + sizeof(union qxl_release_info) + (release->release_offset & ~PAGE_SIZE), (void *)(unsigned long)cmd->command, cmd->command_size);
+	unwritten = __copy_from_user_inatomic_nocache
+		(fb_cmd + sizeof(union qxl_release_info) + (release->release_offset & ~PAGE_SIZE),
+		 u64_to_user_ptr(cmd->command), cmd->command_size);
 
 	{
 		struct qxl_drawable *draw = fb_cmd;
@@ -201,10 +203,9 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 	num_relocs = 0;
 	for (i = 0; i < cmd->relocs_num; ++i) {
 		struct drm_qxl_reloc reloc;
+		struct drm_qxl_reloc __user *u = u64_to_user_ptr(cmd->relocs);
 
-		if (copy_from_user(&reloc,
-				       &((struct drm_qxl_reloc *)(uintptr_t)cmd->relocs)[i],
-				       sizeof(reloc))) {
+		if (copy_from_user(&reloc, u + i, sizeof(reloc))) {
 			ret = -EFAULT;
 			goto out_free_bos;
 		}
@@ -282,10 +283,10 @@ static int qxl_execbuffer_ioctl(struct drm_device *dev, void *data,
 
 	for (cmd_num = 0; cmd_num < execbuffer->commands_num; ++cmd_num) {
 
-		struct drm_qxl_command *commands =
-			(struct drm_qxl_command *)(uintptr_t)execbuffer->commands;
+		struct drm_qxl_command __user *commands =
+			u64_to_user_ptr(execbuffer->commands);
 
-		if (copy_from_user(&user_cmd, &commands[cmd_num],
+		if (copy_from_user(&user_cmd, commands + cmd_num,
 				       sizeof(user_cmd)))
 			return -EFAULT;
 

--=-6YXy54cSZh9okyFnXdLl
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--=-6YXy54cSZh9okyFnXdLl--
