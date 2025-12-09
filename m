Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDF72EAD16
	for <linux-sparse@vger.kernel.org>; Tue,  9 Dec 2025 00:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765239650; cv=none; b=isi55AXpTc5vGWO/ZaVjd7nlwbRMqFlyJKsubS+H1eQBtdsUQ9AZGj2uzscvZy6xRXJAP+g40uEDOEebIrWd3lXBVZHtZb8EOEJd0oYYb9yp5u16tylI6dRnBsFGSGrDam8OoEKShlDxgjei+JXLo3sPSg+KwSgATvmlXdnPWtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765239650; c=relaxed/simple;
	bh=JEk3Jb3o2V3Ykrxdybm6wJkA8vNlfxfi4dCZ5w/NQfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4Lg2GpvshhK+iOHxf8y9Q0hnp2/mnEW7Z2dkgEmLGzRHAe1kAENPvoqHmEbE3RWojcGmgd6abuKA/CScYgNcDbI8vpCE2Hu9rPQAoAN90tvCH2ItCngffgGg4zQvzfqMZQuVjrE6L6uzq7u2j1GvKI4z8ST9lH6x8oxoS6fgUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VqSzYDB6; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VqSzYDB6"
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b7a02592efaso512240166b.1
        for <linux-sparse@vger.kernel.org>; Mon, 08 Dec 2025 16:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1765239645; x=1765844445; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FonhJLVNH15zuQuznSG0KVWWqOZ78Kr7QO87AtDDYSQ=;
        b=VqSzYDB6usl57qPs91xoBvna40G0T/HKIkSasI5LuT4MEKO2hrjM2UlBGHFq1TRaO/
         itUR6WoLg2LXBY2SsCW/nLTCIhdvRrrG8TbKWjW1rUn+tLcVgrDWHv9DrsQ1j9Yw9snH
         fGeiU3Ytf9M9QYhDgYIcsEZZZrjEsRvi3tHl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765239645; x=1765844445;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FonhJLVNH15zuQuznSG0KVWWqOZ78Kr7QO87AtDDYSQ=;
        b=biYS0s0EcvJxQd4LD1EkrVM75k8UhOT2kS/d98AmF//oRSzfBTFnmFEUyNOtLW/6MD
         nG5ND9D5jc2WQX63H1+I0a0DRgsDztF85PSpCst7EFI/B/apobx4zpVqJ4LX/zZotjbG
         6nueCV1HbY6PFLHOq1zt053aEa5+8t4uk2g4AQ+oACJpSWoMCcOjJbscT4UqrVk/cO35
         Aiscg15Ydy6l5VbxWNGmMdMj+waHV53EYLBLU9HfOvJPVJciJl2fTEtI8rZ8Ngi4dza1
         +ZfA1/mHTN22vUzuOyLZzd4TSPCaladTcYdvYj+ZadB+3vBgNY0yDSfIXmIyi7NVlv1g
         iQEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNa03l/w5Q/Jt+QsDbT7kMGm7tqEZCMKHt17zMf8316lSrajfaIReM6hViGBLnq2tKsjdecEiMPcWF8I4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMlY0VWX6w1issibr3HkwkCU8klnjNt5haOjKv1uffcdRWqHiY
	vLQRPpqblesyoDiMIkyEQlDqD3ocngA4z+G5j7f7Mhu3LkHzJlCQKw/XooXHdC0CTNobopcQ1Rf
	Yaqekab7gHA==
X-Gm-Gg: ASbGncsY8dl5x5xyXEyvFnTTtanw0pfgX7gHCDJ2vcMwGxYgdhpykXjfh6glDNuiVCQ
	j87/F4hFjbnQU6nzZ5HSBoPlf6S/NsueS0IP4AauWvrDhBJ3N0jDunmGx4VheDiaalupremPkBS
	gVFKA5dLYE+sj7nmaeNn7zA6pLlGDX8Cjzwoz85gER8X/9jt8EEWdDwQbLoYtKYuTYZfAYqvG+L
	NdIkEan2mWrFS66CHtuG79ee9EeUHVfyFMYEabtCF2/48uGGNXlS5T7U5a5eYUuoh7R6ACzSxG9
	TZ28gFb2i72cYUwL7YxIl6wxLPegY2I8uUsPKePKvOJuKIiERGOBqu9EkZPsuJfWVEtFF0fwtVo
	uJDHpUlqtJZUHLL0ECnNBy4SL5abvezpD1xQfTPSiupO18DK+B0+JCCiFg6ENjmooV/O7S2iAyu
	hJoAd+79ipdC5Xa2lxkjjv3YQ6JNoa9qA6ySRvn6imVDi8EVrQNgABI8K2X96T
X-Google-Smtp-Source: AGHT+IHRc3Dmd4xv9cXUI/70H15jZ+HFxBTgIcOd7qKkl4jPB4bMkAgDhSU4TEyXJwJH/xkCKalJPw==
X-Received: by 2002:a17:907:3e96:b0:b76:23b0:7d89 with SMTP id a640c23a62f3a-b7a24307050mr1058180566b.14.1765239645466;
        Mon, 08 Dec 2025 16:20:45 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f449d5bbsm1245440366b.25.2025.12.08.16.20.42
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 16:20:43 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so8667142a12.0
        for <linux-sparse@vger.kernel.org>; Mon, 08 Dec 2025 16:20:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUwi3ahbnlLKacD+hiMtl8iirLmOB8uro9Ogp+heRTlIgIHFKAHiElsBcX1/ESO0YNUtmgQ5Y83nBJqIzc=@vger.kernel.org
X-Received: by 2002:a05:6402:4403:b0:647:8538:fcf4 with SMTP id
 4fb4d7f45d1cf-64919c10408mr8423201a12.10.1765239641812; Mon, 08 Dec 2025
 16:20:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208235528.3670800-1-hpa@zytor.com> <176523908321.3343091.17738363732550848005.pr-tracker-bot@kernel.org>
In-Reply-To: <176523908321.3343091.17738363732550848005.pr-tracker-bot@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 9 Dec 2025 09:20:25 +0900
X-Gmail-Original-Message-ID: <CAHk-=wi0RqQPHME0xgrAZBQijKuos97cQO05N4f176DkH7msbg@mail.gmail.com>
X-Gm-Features: AQt7F2roobmnBFxkxCTs46omVLlLQvijaEzayZmWK0Hwr8qZTgYHcUtxshIhuTk
Message-ID: <CAHk-=wi0RqQPHME0xgrAZBQijKuos97cQO05N4f176DkH7msbg@mail.gmail.com>
Subject: Re: [GIT PULL] __auto_type conversion for v6.19-rc1
To: pr-tracker-bot@kernel.org, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Laight <David.Laight@aculab.com>, David Lechner <dlechner@baylibre.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Gatlin Newhouse <gatlin.newhouse@gmail.com>, Hao Luo <haoluo@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>, Jir i Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, KP Singh <kpsingh@kernel.org>, Kees Cook <kees@kernel.org>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Marc Herbert <Marc.Herbert@linux.intel.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj <mhal@rbox.co>, 
	Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko <mykolal@fb.com>, NeilBrown <neil@brown.name>, 
	Peter Zijlstra <peterz@infradead.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Thomas Gleixner <tglx@linutronix.de>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Uros Bizjak <ubizjak@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Ye Bin <yebin10@huawei.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Yu feng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-sparse@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hmm. I think pr-tracker-bot is being confused. This one just came in,
and hasn't been merged yet.

That merge commit link is for the hwmon pull.

                 Linus

On Tue, 9 Dec 2025 at 09:14, <pr-tracker-bot@kernel.org> wrote:
>
> The pull request you sent on Mon,  8 Dec 2025 15:55:26 -0800:
>
> > git://git.kernel.org/pub/scm/linux/kernel/git/hpa/linux-auto.git refs/heads/master
>
> has been merged into torvalds/linux.git:
> https://git.kernel.org/torvalds/c/b88b2f82fab45521cb32c0b737266d90a66a748f
