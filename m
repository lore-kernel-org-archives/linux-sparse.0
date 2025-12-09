Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3111A0712
	for <linux-sparse@vger.kernel.org>; Tue,  9 Dec 2025 03:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765251667; cv=none; b=nHFy5Sq94135OgJfYQoGqmbjEHN6JBpa01lG0CVkIK8EgJsu87AAOZzc1hR2CzRtNgHG+04NE+39DKGn1M5mVqSn+drotVK2MXwCgzzSQyb7axWPB9sIjHiy1P4cPVtoJAGnNdeaPCm7zSGErJwZiQVJ5llxHzw6SoncA5kCH2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765251667; c=relaxed/simple;
	bh=mArw2vAL0D2NHk8zLQ2Ijxxx1bFuIg9r7rH/hnyrq/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpIDEDc/6eMT4CIvdqb7ImPXPpYsaH5A++LBu3wglkkL4wyCPRO0W7q++h/oYG7UYG8gMINGnbpqSGAysfUkatdEl+dNjNvVALtC3j7RzmWcSze+RlaYs+YpVVmfzIOv0WyR1FYsQMO3JM2plCO1XbEzl5Ofz085+FYvFFZxuoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SIy4f8Ba; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SIy4f8Ba"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so7586562a12.1
        for <linux-sparse@vger.kernel.org>; Mon, 08 Dec 2025 19:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1765251662; x=1765856462; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ve41G5hMhFJfqXtFvhXu3GnjjOI5g5mevMdggrYlYVI=;
        b=SIy4f8BafISTauU/V/46v+naSpEHevno8Np7QQvhlgmy2xhsruMu5iQkZTKMETWUjA
         ndwPlDGejVAgxsDk+kVvtZQehnZ3oVe0lrAMcCD3+PIAf4ySo2qc7GGKvz9dh7LnNX8W
         TgFtQHCM+wNI1tjfHKZO89N6wyFYKV2oIlyng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765251662; x=1765856462;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ve41G5hMhFJfqXtFvhXu3GnjjOI5g5mevMdggrYlYVI=;
        b=p4vcPhZJImNkpcnjc8xZ4Jb4BypTgjQ3/YrDqPGvlc3dfmAiUw8LWV1LmH4LY3FoE0
         tqi4qSyUGqQX+xClzle3hvNj5Aggx1wCzEfRtOEu485TYCwK2qfgskS34Ixy2EP/IJPO
         95q+J4fqTfgy71PRFOrUFysx6tIolzrB5tl6ReZDeQ9qxYkhI4FFYR+oKwxkeElJtX1o
         9UPv8BPC9DKJXRLyIRiigrPv7K+x43zqlSbWm73aVEOcpOyWds9AvmgslclJN2ub0wqX
         B6t5JdhDdsZjIJWD8DC354OIkfxKKtSWC5QrK1zje+AI5BqUtItWKDAaq8wMFj2HsQxP
         o6aA==
X-Forwarded-Encrypted: i=1; AJvYcCXJklhpuzkTB6BNFc3GC9rPiSmMjqt64RPL29SvZ5X7yO4CIbHLzDvi5QhdyKAMVRZa3HtYU7bA6zb/1CE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI7v5BFbzq1QARf4ko0n6GXzXspi3CWHpdDQLqoyYVCBgrArL3
	i185dboaN4Kz9hnRZe4SlfUyW5hmjVS93ISxuEpTnfOqVB+s/4zK0Ym5Jc2doLWiOaK2IYnDI7A
	rhyCvgXroyw==
X-Gm-Gg: ASbGnctC5CLAydy6kCJL/DNQk/mgVZjWnuUyi9RC44XWznTsFQ4d9dzpXfF4wCjxfCB
	iM7plgFIw1aG7Z0qVx7Q+LGRjxz/LuRoaOZhEs8USIoyFV7pjr+fEEih3aq9NBdPKQ5Qwisxt6T
	cD1RX+tMbJoex/0AZAhOCtcSHfTHvx9jXfOQCoXlJnFAeKGt+IPTTWOfpCzBi4vQepila8zLgb8
	S12odhe+HhUkdPM5M9QAcMq5IqEfJIzJ9ZrmDZOXgujioWppF8p6TTQj8wQSoP88X+t3t/JbRjt
	Ege9JhpS7m+Z2L0gFzpyxSe0RCVgY+OR+DYRA864ccldbKPa9JFdMUxovcQB3ejn+WX7v8nhbCz
	kl3bmh3nATvWquJ8/KErT9nW2irE6RgwWc+HG0kqw1Xcm+a3cAPndO/SrRvM5q+pKpc4PdeImSC
	Hr4JDWETqpBn791JawcbtWoSkDbvnU6Wn7O7ocjAp7yUmo4tF/aaV1vs/eUoiA
X-Google-Smtp-Source: AGHT+IEOktBKVfK2hr7B71Di/ytjRzUK2nYoMZwmGYl7a82Nd85PzypGkaqsaSXUIE59hvo92zI0Ig==
X-Received: by 2002:a17:907:25ca:b0:b77:1a42:d5c0 with SMTP id a640c23a62f3a-b7a24827918mr1027915166b.43.1765251662426;
        Mon, 08 Dec 2025 19:41:02 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f49765f3sm1222474666b.37.2025.12.08.19.41.01
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 19:41:02 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4775ae77516so61572955e9.1
        for <linux-sparse@vger.kernel.org>; Mon, 08 Dec 2025 19:41:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUfizHHVISlVcWMztL/rqhpO0+dXvrTabAI9TYISodwzBNL5Hj9FNg5xKzv8cyuO04u/LUxcqPvVx64Pt0=@vger.kernel.org
X-Received: by 2002:a05:6402:d0d:b0:647:5e6c:3220 with SMTP id
 4fb4d7f45d1cf-6491aded554mr6980906a12.21.1765251222388; Mon, 08 Dec 2025
 19:33:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208235528.3670800-1-hpa@zytor.com> <176523908321.3343091.17738363732550848005.pr-tracker-bot@kernel.org>
 <CAHk-=wi0RqQPHME0xgrAZBQijKuos97cQO05N4f176DkH7msbg@mail.gmail.com> <ee693efe-5b7b-4d38-a12c-3cea6681f610@zytor.com>
In-Reply-To: <ee693efe-5b7b-4d38-a12c-3cea6681f610@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 9 Dec 2025 12:33:26 +0900
X-Gmail-Original-Message-ID: <CAHk-=wghm5NFZQcfObuNQHMMsNQ_Of+H7jpoMTZJDrFscxrSCw@mail.gmail.com>
X-Gm-Features: AQt7F2ofRIAXVmCzZb3EAMnphwigz_H3r18InwGDDrhalL1GL85PEFWZ4uBTknk
Message-ID: <CAHk-=wghm5NFZQcfObuNQHMMsNQ_Of+H7jpoMTZJDrFscxrSCw@mail.gmail.com>
Subject: Re: [GIT PULL] __auto_type conversion for v6.19-rc1
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: pr-tracker-bot@kernel.org, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
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

On Tue, 9 Dec 2025 at 09:24, H. Peter Anvin <hpa@zytor.com> wrote:
>
> Yeah, it commented on the master branch, which is of course ... yours.

Ahh. It's because you didn't use the standard pull request format, and
instead did the branch name elsewhere.

Which btw also messes with my "just cut and paste the address" thing,
because now I'll cut-and-paste two different things.

"Poor Linus - all the pain he has to go through".

          Linus "think of all those extra clicks" Torvalds
