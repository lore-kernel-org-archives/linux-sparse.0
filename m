Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5D1356A24
	for <linux-sparse@vger.kernel.org>; Mon, 23 Feb 2026 10:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771843933; cv=none; b=Z4r5cDkJoXuXms05cJPcagQxaFGfb8RCpXpjkSrKqahrXeOtPk+mmENWKrK9ziBWw4uImZd7lC8M1pHg8tCxMNzT+jg5wlkqMCKgsdo3sE7a2BqXcYw/oOyhdYLkbWKSW/Y9Qh5w2EJn+ytS5g5Lo5M0PaPHzsatXTnJ+lslRXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771843933; c=relaxed/simple;
	bh=lyiMyQ9PT6ZwlqNH/FnyNuTQ8KzTfPZcN/Uattr3chY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MKUrfr/vgf4Mkl2sNayqQNaY36qRp6IrfumO2VkFYjbOJRb5y8EX4RAzwjM+y2MSx3idYTyrPpg+5JYE8CHmIGJ9P6c5YgwL5ihvJ+Ps7nLIDfk5E/ZeCoGxWsr5veE+gs/m0TTgY1/VYjdWk2CoHNwr7gvwpkBxK5zJAggHEI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AvDkbw1j; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AvDkbw1j"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65be78011c8so5794768a12.3
        for <linux-sparse@vger.kernel.org>; Mon, 23 Feb 2026 02:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1771843930; x=1772448730; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a7UVCpURj0hGhJeAMPOL1rLRHixZquQlyR0XZy4yo88=;
        b=AvDkbw1jcaVrOiFgiYj/MsWQ7+c/42c54zzRvR5pkKIfOXg6iDmu9dLIpeC7Tl9DhZ
         IyRgOfA26Xm1bnWbF/8xo5UGDCn3gARVhm/NFHtVfYP4EGxhsS3YhXPdt3jzCqulbvrU
         SfcbuIz00+oCJ0YnaEaGdLNvS8zH5jd8qKlRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771843930; x=1772448730;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a7UVCpURj0hGhJeAMPOL1rLRHixZquQlyR0XZy4yo88=;
        b=isplcPhKWFhAxYyXH86YKb8j1bbIget8RHKHTo3L3xbcZmxrYnihld/4Vot6vufmFt
         jZGfiDDyXb7eEZxyAziXwt+Fog7l5WVjg5ZNFedlMj9GPk8fxGuMLE57MNga3Mduy883
         pnFL0NM/GDqjm2jOhNuoyjsYI1TE18EcLhr/SK7H0wsSNdXnbz4puo3Ox4tAL+KZJLSN
         UVoAaj2K7XzxoEXu+AwsBTpxynwaZw5nOgdtiT9Z3npauN7UDblgdHrOTWr7nd2DHBfS
         vymJuXtDeCHOLjyIIxAafIZh2qVbfXqAHJvR+N5CiRFmC+R9Ww6y8bTFOdcytQCY0Vxk
         ZN/Q==
X-Gm-Message-State: AOJu0YzEOw/SGUrkJz2KlnEACw0mnrOQztJG6J2vWNc6gGv4qmBx8L25
	HMsaPHqsPjQPYcBnK60J59y+XN/1h1uJE5R8sm5803lfPhbJ6/34AV9Mn1mH0AeKIjSO174ImhK
	ujlvE1o47
X-Gm-Gg: AZuq6aL7uQcmqsKKxo6DoO/zz3LglHVwZGjejfPRl1hS/Z6qwHUygtjO/RXH3cCG8/d
	vlYwpOcxwQo+pYXLmNzZTYblzrXicIRgAzP8p+XYu1G5T8jPyxDZtIwfgJDXEnMiZqR1mXhKZAy
	QaBK6ykfsSPVXI5D2TiApaAVqacgY3zhe8EdoZE72zzHl2+xmIMij0/x8aVrGf12pW1gHpRdnGN
	Qryj9AzxsGUrZ7Px/6vo4ccB8QjTWfEuMyLkw98ZmY72znOsitpAVO5LHtUJUU23a0eHg/YkRw3
	VSFd1RBF2PLv9eNxAAhjumbFpGSB3Wn1c63r8q93NESqQ1YqWkcb3363/mXHqoWgP0MuhIvvBl+
	+4kzZLOWAT3UiUz1OwqjjM0E0Hf/3UG0JhOhsQfaTYrJ51c7rd5vuYK5RHPdTXGv4YYLZZTnS9p
	nSFHZFTyuaygL8seuIkOSTYnF2Bvy/SXNA/43b1prWsNQuxH5X0xwpPvLzQfHH
X-Received: by 2002:a17:907:5ca:b0:b87:9b53:b67c with SMTP id a640c23a62f3a-b9081a2aa12mr515528566b.26.1771843930057;
        Mon, 23 Feb 2026 02:52:10 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084eb912dsm315792866b.55.2026.02.23.02.52.09
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 02:52:09 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b884a84e622so625410466b.1
        for <linux-sparse@vger.kernel.org>; Mon, 23 Feb 2026 02:52:09 -0800 (PST)
X-Received: by 2002:a17:906:f59a:b0:b8f:e9fa:ddf7 with SMTP id
 a640c23a62f3a-b9081b81c67mr505450166b.40.1771843928021; Mon, 23 Feb 2026
 02:52:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 23 Feb 2026 11:51:56 +0100
X-Gmail-Original-Message-ID: <CANiDSCuKGUNdT4f9tOuohe2wZeP4MmooJAJn2Q=oyAWL4v9Lng@mail.gmail.com>
X-Gm-Features: AaiRm53cRkkUZsTlZkaGI0L-h1Z93-cgRw0wmI4cjCd6JdiSWqxm29VVzA_nvrE
Message-ID: <CANiDSCuKGUNdT4f9tOuohe2wZeP4MmooJAJn2Q=oyAWL4v9Lng@mail.gmail.com>
Subject: Sparse not supporting kzalloc_obj() and friends
To: linux-sparse@vger.kernel.org, Chris Li <chriscli@google.com>
Cc: Hans Verkuil <hverkuil@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi

In media-ci we use sparse for static analyzing the new changes in the
media subsystem.
Since 7.0rc1 sparse is failing with errors such as the one at the end
of this email.

The culprit seems to be the new kzalloc_obj and friends.

I have been trying to add this as a workaround:

$ git diff predefine.c
diff --git a/predefine.c b/predefine.c
index c6750831..821100a2 100644
--- a/predefine.c
+++ b/predefine.c
@@ -208,6 +208,16 @@ void predefined_macros(void)
        predefine("__extension__", 0, NULL);
        predefine("__pragma__", 0, NULL);

+       add_pre_buffer("#strong_define kzalloc_obj(type)
kzalloc(sizeof(type), GFP_KERNEL)\n");
+       add_pre_buffer("#strong_define kzalloc_objs(type, n)
kzalloc(sizeof(type) * (n), GFP_KERNEL)\n");
+       add_pre_buffer("#strong_define kmalloc_obj(type)
kmalloc(sizeof(type), GFP_KERNEL)\n");
+       add_pre_buffer("#strong_define kvmalloc_obj(type)
kvmalloc(sizeof(type), GFP_KERNEL)\n");
+       add_pre_buffer("#strong_define kmalloc_obj(type, flags)
kmalloc(sizeof(type), flags)\n");
+       add_pre_buffer("#strong_define kmalloc_objs(type, n)
kmalloc(sizeof(type) * (n), flags)\n");
+       add_pre_buffer("#strong_define kvzalloc_objs(type, n)
kvzalloc(sizeof(type) * (n), flags)\n");
+       add_pre_buffer("#strong_define kvzalloc(type)
kvzalloc(sizeof(type), flags)\n");
+       add_pre_buffer("#strong_define kzalloc_flex(type, pos, n,
flags) kzalloc(sizeof(type), flags)\n");
+
        switch (arch_m64) {
        case ARCH_LP32:
                break;

But it is a dirty hack and the fact that the macros support
"polymorphisms" makes it even uglier...

I have been Googling a bit, and I cannot find anyone else complaining
about this... which I find a bit weird.

Am I holding it wrong?

Thanks!

$ make -i W=1 C=1 CHECK="../media-ci/third_party/sparse/sparse"
drivers/media/i2c/tda1997x.o
  CC      scripts/mod/empty.o
  CHECK   scripts/mod/empty.c
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/modpost.o
  CC      scripts/mod/devicetable-offsets.s
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTCC  scripts/mod/symsearch.o
  HOSTLD  scripts/mod/modpost
  CC      kernel/bounds.s
  CC      arch/x86/kernel/asm-offsets.s
  CC      kernel/sched/rq-offsets.s
  CALL    scripts/checksyscalls.sh
  DESCEND objtool
  INSTALL libsubcmd_headers
  CC      drivers/media/i2c/tda1997x.o
  CHECK   drivers/media/i2c/tda1997x.c
drivers/media/i2c/tda1997x.c: note: in included file (through
include/linux/i2c.h):
./include/linux/acpi.h:69:18: error: Expected ) in function call
./include/linux/acpi.h:69:18: error: got ,
./include/linux/acpi.h:69:18: error: Expected ) in function call
./include/linux/acpi.h:69:18: error: got ,
./include/linux/acpi.h:69:18: error: Expected ) in function call
./include/linux/acpi.h:69:18: error: got ,
drivers/media/i2c/tda1997x.c: note: in included file (through
include/media/v4l2-common.h, include/media/v4l2-subdev.h,
include/media/v4l2-device.h):
./include/linux/spi/spi.h:1312:15: error: Expected ) in function call
./include/linux/spi/spi.h:1312:15: error: got __VA_OPT__
./include/linux/spi/spi.h:1312:15: error: Expected ) in function call
./include/linux/spi/spi.h:1312:15: error: got __VA_OPT__
./include/linux/spi/spi.h:1312:15: error: Expected ) in function call
./include/linux/spi/spi.h:1312:15: error: got __VA_OPT__
drivers/media/i2c/tda1997x.c:2541:17: error: Expected ) in function call
drivers/media/i2c/tda1997x.c:2541:17: error: got ,
drivers/media/i2c/tda1997x.c:2541:17: error: Expected ) in function call
drivers/media/i2c/tda1997x.c:2541:17: error: got ,
drivers/media/i2c/tda1997x.c:2541:17: error: Expected ) in function call
drivers/media/i2c/tda1997x.c:2541:17: error: got ,
drivers/media/i2c/tda1997x.c:2541:17: error: undefined identifier '_res'
drivers/media/i2c/tda1997x.c:2541:17: error: undefined identifier '__VA_OPT__'
drivers/media/i2c/tda1997x.c:2541:17: error: undefined identifier '_res'
drivers/media/i2c/tda1997x.c:2541:17: error: undefined identifier '__VA_OPT__'
drivers/media/i2c/tda1997x.c:2541:17: error: undefined identifier '_res'

-- 
Ricardo Ribalda
