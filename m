Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4146E2D0C7F
	for <linux-sparse@vger.kernel.org>; Thu, 18 Dec 2025 22:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766095621; cv=none; b=HpknZNVpU06slmiZoO2PFu8brDH4CDlfgegQA5knbstCDjV/n2Gg04hZcurAikhSiDC2+Q2l4Wz66QIeUKZ/ySwIglUbVYeuSLCjIsajPKZUKelh9WQq6W+0XV1WJS31fz3tMsO2FGhTBIlIJEUnEN9sHNkNxxLx9xHjJCckRjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766095621; c=relaxed/simple;
	bh=J4Nn2NlGfDoMoLD2jX96Gn59VTZ3FbVS9Sq+YlKTdug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F8iEdJMnI+YW7dBSe3rYdKL6EryVSIZBGh2ATdBUSqziR+KE+SSWu12Ya5yFyeLiXMTpjUqygJmxZXS4DmSq5f4PAUTb0iuVaJTUjw/CjEssv3aES2VJGRBiSig+kzbXHG5giGrLjRbrjEFSrg4KtvGWUUYA7RLZPyjWnVs75Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liKa0KNf; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liKa0KNf"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477aa218f20so7619365e9.0
        for <linux-sparse@vger.kernel.org>; Thu, 18 Dec 2025 14:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766095617; x=1766700417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCWNyqqNvxqk0sIuAi6HOTqP3nuQgibcAJ59og/NAJg=;
        b=liKa0KNfSTlpJ0iuaL+p+4S0MpSmTpX9aE6o7KTOJ4tWOjF/2WPsQTVt+WcI6RtCxk
         aQTODRmXd5geqIg+VVirxkzakC0b6jlg2gGV7YjMeD3uGS5G9wezTa5PzxHIL0A6Rbl0
         RgxtZDfCJsXR1MgSk+ahQCQA9+zMjQxyyEfwTVT/8gPfb//3SKWbw+RnVvmLfn8LSvax
         +Pk0ck1dkIIPqKfkHmaR3HFoJ+28UAb8em+W1IeQs/xEZi5x/v6sUtFYra83UrWCOQdq
         WwtOcbCZD5NoybFueDbdIW8mk6uEadc2PhTVvR2QhK09ab0IOiTLrkro1jx067TP95l5
         bbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766095617; x=1766700417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FCWNyqqNvxqk0sIuAi6HOTqP3nuQgibcAJ59og/NAJg=;
        b=oFZyZ8FW0TIu/dIrknzMSRF5NNSNyWzSct6uOpbvmTa30nZlH3KUIQkFOUshQb9bDL
         ETqa1VNbKz+XIXs6L5teAxNd2pIy4PrfgR2APL8+qayhyA9uCij4iIxZgLlcYKH4ZtCc
         KquwHmklqzC6p0KRSKWXbUH97yeuF5wTGFDxBGmjTmtZE5ITgC+KQ6qVz4D4nbVQljda
         o8yujyRt/46xIAaiwI9C7WGtL7giQ9rtoEo9aLXG6ivPS3Wo5HohBBFCX6OOTSxeg9Up
         5vMqCZYKSlRO7WTXXxUlejl2oOQoBKViEVV4zD+MVrr9p4aJtPCtegnCOUkQlzmOzjXW
         OB7A==
X-Forwarded-Encrypted: i=1; AJvYcCU1HkJZ6IumHzkHcPoMz74FdCrpADaZpOlpJzd/oOspkpF/HWslvTPmzVgIAyp5lc7b0nxm2ygikScDDCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2oiSbpJa/JpmZTqxIdMBb3v7ZCaANUbtWG1hX+uyOjJcSq41D
	tyNCVS6s/DJxs0pVK34voGgTMiHrYth8xVcsEN5g8xuDqvNkjua9x/Tp
X-Gm-Gg: AY/fxX5pF5FD7PtUZoRvGIRjaf3ZpTHTViXmLRjqUhz+gl+vzD/hjYnDtFr1gVOP0GV
	qhSkPQFDUOwErW7ohbO68smK5Ul9F1PEs895ZeWnJ457RtgiZYZ309NgOHGySkeCcUzvyGZ0HxW
	eBBXrVcWdqME5LX9TKafUVa6n03qhsaeYEn6eL/1l6+cwfxJNsPw+LO5qUX6+kcsDpg5UQ8UnmP
	zT/ItHiRCB+LzCWAQwTJgWFGv3Lc1qRpRKBOuQ+SZbPvxnGmW3EqpAaD0kbMEn3NVOzVv6GgoTG
	Nm34K28rqP2qe5Y55VZjLFku334ECHuxzFdbiLL2F5n+8fq5GLlJlbhwa210VDhuoxrTbLJoFD1
	/2/rHYOVHhEJlE9v+XKKUTMrVaeg0hjq//r8Q0+FdJs5tsuWk0aN3toud0QJ+06nrSVqUWdoWrU
	CTUTriHZ4aFVvi2JUTgBhfj5rdtWqTBDvTZcEKR58lYkWkZet9zLQq
X-Google-Smtp-Source: AGHT+IGTunC8kRSxjImDPeRC9HvKyQNV1Ibv0KtdSMjVnMShq1E8PEmRrIAevTE0VIl4mZ+C4NDiJQ==
X-Received: by 2002:a05:600c:3b8d:b0:477:7725:c16a with SMTP id 5b1f17b1804b1-47d1953da58mr7304975e9.10.1766095616415;
        Thu, 18 Dec 2025 14:06:56 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be2723d19sm71561025e9.2.2025.12.18.14.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 14:06:56 -0800 (PST)
Date: Thu, 18 Dec 2025 22:06:51 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vincent Mailhol <mailhol@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin
 Stitt <justinstitt@google.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Chris Mason <clm@fb.com>, David Sterba
 <dsterba@suse.com>, linux-kbuild@vger.kernel.org,
 linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] kbuild: remove gcc's -Wtype-limits
Message-ID: <20251218220651.5cdde06f@pumpkin>
In-Reply-To: <CAHk-=wjrNyuMfkU2RHs28TbFGSORk45mkjtzqeB7uhYJx33Vuw@mail.gmail.com>
References: <20251218-remove_wtype-limits-v1-0-735417536787@kernel.org>
	<20251218202644.0bd24aa8@pumpkin>
	<CAHk-=wjrNyuMfkU2RHs28TbFGSORk45mkjtzqeB7uhYJx33Vuw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Dec 2025 08:34:05 +1200
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 19 Dec 2025 at 08:26, David Laight <david.laight.linux@gmail.com> wrote:
> >
> > One possibility is to conditionally add _Pragma()  
> 
> No. That compiler warning is pure and utter garbage. I have pointed it
> out fopr *years*, and compiler people don't get it.
> 
> So that warning just needs to die. It's shit. It's wrong.

True - especially for code like:
	if (x < 0 || x > limit)
		return ...
where the code is correct even with 'accidental' conversion of a
negative signed value to a large unsigned one.

clang seems to have a dozen similar warnings, all of which are a PITA
for kernel code - like rejecting !(4 << 16).

_Pragma() might be usable for -Wshadow, which is generally useful for
local variables (but not global functions like log() and j0()).
(I usually enable it and fix up the consequences.)
Things like the masked userspace access define which carefully
creates a readonly variable that shadows a user local would need
to disable that one.

	David

