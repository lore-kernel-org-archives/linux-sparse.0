From: Blue Swirl <blauwirbel@gmail.com>
Subject: [PATCH] Ignore attribute __bounded__
Date: Sat, 7 Mar 2009 13:22:01 +0200
Message-ID: <f43fc5580903070322v50f7e920u91ad580156cc71ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636c5b496399a100464859c9a
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f178.google.com ([209.85.218.178]:56886 "EHLO
	mail-bw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbZCGLWF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 7 Mar 2009 06:22:05 -0500
Received: by bwz26 with SMTP id 26so651797bwz.37
        for <linux-sparse@vger.kernel.org>; Sat, 07 Mar 2009 03:22:01 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

--001636c5b496399a100464859c9a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Ignore attribute __bounded__, used by OpenBSD headers.

See also an obsolete version at
http://marc.info/?l=linux-sparse&m=113344255600417&w=2

Please CC me for any replies.

--001636c5b496399a100464859c9a
Content-Type: plain/text; name="bounded.diff"
Content-Disposition: attachment; filename="bounded.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fs046466

ZGlmZiAtLWdpdCBhL3BhcnNlLmMgYi9wYXJzZS5jCmluZGV4IGViMzE4NzEuLjIxNDY0NGUgMTAw
NjQ0Ci0tLSBhL3BhcnNlLmMKKysrIGIvcGFyc2UuYwpAQCAtMzU3LDYgKzM1Nyw4IEBAIHN0YXRp
YyBzdHJ1Y3QgaW5pdF9rZXl3b3JkIHsKIAl7ICJfX2NvbGRfXyIsCU5TX0tFWVdPUkQsCS5vcCA9
ICZpZ25vcmVfYXR0cl9vcCB9LAogCXsgImhvdCIsCU5TX0tFWVdPUkQsCS5vcCA9ICZpZ25vcmVf
YXR0cl9vcCB9LAogCXsgIl9faG90X18iLAlOU19LRVlXT1JELAkub3AgPSAmaWdub3JlX2F0dHJf
b3AgfSwKKwl7ICJib3VuZGVkIiwJTlNfS0VZV09SRCwJLm9wID0gJmlnbm9yZV9hdHRyX29wIH0s
CisJeyAiX19ib3VuZGVkX18iLAlOU19LRVlXT1JELAkub3AgPSAmaWdub3JlX2F0dHJfb3AgfSwK
IH07CiAKIHZvaWQgaW5pdF9wYXJzZXIoaW50IHN0cmVhbSkK
--001636c5b496399a100464859c9a--
