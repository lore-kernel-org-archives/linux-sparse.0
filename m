Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C3521C17D
	for <linux-sparse@vger.kernel.org>; Thu, 18 Dec 2025 20:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766089610; cv=none; b=UiZ0W6ayfN0NMBAwSoWkOjL0qwZGbrA87n+uslkCMVjFc6wycvDjsifm6UQvGKzhwMvJYTtTFVaKn47ZG4RYp/2stimgazLeX6jSHMpkMY0xp10shFzw8ocXoEFeZ3D5IT3942Wi+Z7J13yasU6AzpDkvyl6EDjM9uhKJI3F+Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766089610; c=relaxed/simple;
	bh=v5r1UHjsCj16c8Aasp3mvbgbCLuKmbAvogVL8SAdBfo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=US/xMmfBV0HNH5tD26GOf7kUm6i0fOURMPM0gkTKdPTP/Sd2P00iBmn5onl6d0n8iEWgp9RvTcSHYoQxuc65ENB7ROeabVFzEcjVfJZREy+k1VnjEXIEO91XolRgePjxxQq4vEpRWbHXrz0Lw1MMz6iGHxU25Djh8mGqmNfoJ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4oOR5St; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4oOR5St"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso8278995e9.2
        for <linux-sparse@vger.kernel.org>; Thu, 18 Dec 2025 12:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766089607; x=1766694407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgQxtQzmfa6dtQc2HKAnCJeJmQcolaeO4Fk6tR2yJow=;
        b=A4oOR5Stdx3432l8u0TFufSmg3nigHFbi0j4qVcs5l8+J2e16idgnkEp8v24X2Za2R
         UaDr9dn0rxN41opN86iQIo2EaHonZEh7rqZ1GQZ90yuYaDVQZsEcxOf1ScUp7+H66Edi
         bZQq2r3ZygQLznT5rXGwpHqeoTdxD2B54ry4urWEtcmsmUVNYFi+FJLxHeJ24A4ZVY2e
         0P+5d4Dscix0f4qwIn02b0NV540/JkZbM6hQ10DqfdbIniYY9JcXRKyQraT+fIzTyLbF
         6SIvnw2RkuoEgr38NPkpxeqHPZZDfQnCqomiKutpplGsdLYruWq49tmLzWthCQ+JCj45
         H7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766089607; x=1766694407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vgQxtQzmfa6dtQc2HKAnCJeJmQcolaeO4Fk6tR2yJow=;
        b=HekygAd/uPTIg+4LOOW2k1jU/87EWXYgIQGR1+d37TxLMK7RtlOPSeb0LFq7xs87Br
         FKYu1xn4gYac4N3t/8pfrZ6Hr7Wmf4W7lGLiAGYMVJS9edlr3cNH0/7i3Jt0QRj0qOZk
         uW9c16Fiyf2kplpyKhJN+gbBAO+v8vZpZc959GrwkW1dmoeR4EJjQOLJxPqmhJj4WqJX
         lLcxC/uJFeq202gSfFginqXaaOeQeR1jRHk+HEDEPCBomZl7+lF1ClWhiFb2nMgz0mz9
         EeMjfE6QKzSk0m9Nud08tghSTMh0I2spbetASjRPXukRZ5UaMZxhyJntxgj6zfzynyyP
         W5yg==
X-Forwarded-Encrypted: i=1; AJvYcCWvZQRnk+AqT5YbnbRlnkMzg6NIDHSkygF6KCMCwzH5V3K3IsJTaZ+fIQIkAFJGaQOkZuWXa25ISz479ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfYcXuTGOphaz6x/C4V+0Ylq0iARI/6aa4FlD6LcpYbWeltyB+
	jzEU5gFthi9fFURTjBY8PnklvRRDiJLi5qdtk+oJwr8YwYfDv1fJk+5g
X-Gm-Gg: AY/fxX5Ejy6b8xsUj5athw7p+gtjsIxte9wPhSmTJPGa4OB6eLHMTIKOS1glLstdq+0
	Ncx2g6gK+giCzU49j3pF9bjhbIFhXYIBEWjZRgKQpOmwCibz9FTC16LPEVKEQEJfo1AzIWe4rki
	cDXHTGtoU6jvg+JZWVQKc8SN5ZL7cdJj5763cKXhKpRzVzK/W+tCq49UB4IFneD3PORSlg28tmI
	bwAplqtxMA1UpUbOgjbRwtdBzNaBLRYKhkww2FgIpxyTgil/SgT7OP6Jcocx3K9er5kD5vLM54y
	Zftnf64K15dHDIp8IsY4DAtSaLu6ifD4hkp3CAIWECqEfI1i2kVyQptMPzK516wMxi2lRWq+ms6
	zpu57J/YqgkGpYSCPs1+6zWAOJlDPiiC5V5WVQw1m2JA3mmgr3hTwH5gXTuPmm3bpjot+oi4hxe
	zb3MKMRgdRkN4UjIyJtoQdfFzwWEre4A2RSUlzhI9oN7JLPpJ6CkqL
X-Google-Smtp-Source: AGHT+IFDrnuciBUHAt5nZOA+oA3L3vvumVlk/WEBkRVYYRodfFUMiH6N2Ng/k7jEFXB9WnpS2Kxx5w==
X-Received: by 2002:a05:600c:46cb:b0:477:7f4a:44b4 with SMTP id 5b1f17b1804b1-47d1953b78cmr4635005e9.1.1766089606918;
        Thu, 18 Dec 2025 12:26:46 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa08d9sm872464f8f.30.2025.12.18.12.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 12:26:46 -0800 (PST)
Date: Thu, 18 Dec 2025 20:26:44 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Chris Mason
 <clm@fb.com>, David Sterba <dsterba@suse.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-kbuild@vger.kernel.org,
 linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] kbuild: remove gcc's -Wtype-limits
Message-ID: <20251218202644.0bd24aa8@pumpkin>
In-Reply-To: <20251218-remove_wtype-limits-v1-0-735417536787@kernel.org>
References: <20251218-remove_wtype-limits-v1-0-735417536787@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Dec 2025 19:50:00 +0100
Vincent Mailhol <mailhol@kernel.org> wrote:

> I often read on the mailing list people saying "who cares about W=2
> builds anyway?". At least I do. Not that I want to fix all of them,
> but on some occasions, such as new driver submissions, I have often
> found a couple valid diagnostics in the W=2 output.
> 
> That said, the annoying thing is that W=2 is heavily polluted by one
> warning: -Wtype-limits. Try a gcc W=2 build on any file and see the
> results for yourself. I suspect this to be the reason why so few
> people are using W=2.

One possibility is to conditionally add _Pragma() inside #defines to
turn off the warning for the main false positives (I guess all the
BUILD_BUG_xxxx and statically_true are the main ones).
But don't 'bloat' the #define expansions for normal builds.

	David
