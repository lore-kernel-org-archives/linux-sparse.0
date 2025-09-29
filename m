Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E417248883
	for <linux-sparse@vger.kernel.org>; Mon, 29 Sep 2025 06:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759126691; cv=none; b=SXQ8rIYl27HF97nwuUMgzXa4WtrUCNnBEP956D5qeCcqulCqhYWEXAx3ScqnVwNua9uIi+JiZTVMalM1tAtsEnZlvEZpzU9Ufy75zpg8C4J9J7hIjyVyKPXmKouxyIICtRCW7LrL7BQMVn/bG++oVCIOiBA4NUoEBdUl9LzfZm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759126691; c=relaxed/simple;
	bh=TaE9E5X+qP+c5BPo+iL5FnARgMXo5Rpi/JvUKso9AR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdjhr8jb0mL+8sKoesbExZL3HU5n/fIQ6RAor2qWT55fh83be8sL1NLFAFKDJIRZg6Z/8SpIrMH+ZXg+tGfKPx+sCqLY41ioBCg7WA3biR4DQiieZjnvZEFWdxv/WEk7DDbUEgoBt7uJj1NR9qxjqLppH8K+jNG1hi2PoYPnhyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6352c8b683eso4454970d50.2
        for <linux-sparse@vger.kernel.org>; Sun, 28 Sep 2025 23:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759126688; x=1759731488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TbaQwHjIPUqK+cJ28B71I0FxLHaQC6uEvoYImnsDyjY=;
        b=SJ1pvGskqeV31O9c7ciJu8qOWhkSZCbexZc/KBCYq63/zRbj47EfKFL0QgTh+lJo32
         dR/eHapmHPFhYr1fkOJVMphf0FTxps79D6mTBhRQPa0W6YMXjjNm8wlL9alrnMsxIzB8
         T87bzIXiuw6L5ukU6ergWS1OjJDNHEIyLkpT2T3TaDVfHpPznpXE118dbrUOrSIouuhD
         EpVuNg4k2GGvHo579fabGi1S5MhNKEzZhynOcyO5xdCSn0yI5rCQDGlcwXCQXFbrwlc2
         3OFh4hyM5sAsX7bfjHk1z1gmylt7aSsrnzNIQLzFeKDVoVcl+i3Wn6Yuf6eEIXpTbuj5
         Gepg==
X-Gm-Message-State: AOJu0YxwUnRaKfcP9gTyd+lokwuXaswm69rnYTm7PlBly0EpF9TmY8KT
	m+Xhidetilxph/5JtqyqdFHAzb0Kiv8AI7OeS7NhMNeYXCMLqse5pEE+LiiCFpHbAkAlPVQs1rY
	ZkgQ2H0/39wCDVzRjNLnCmWKMutH2dHk6IcV4uAHSr806xmphKmK3sRQ=
X-Gm-Gg: ASbGnctquqiKh0O3tnl80RM0gZ8/SCyIbPuUvH1ss04l3z7wgmA6Ntxhuy2QHQz6Va4
	YNpMRBgD36iiBvLk5pj7NcMuckWV7BOYrf8IhON7XTFWoKWEOgcR+RyA2a60yUVr3UB9el40RR7
	MPkE/IYzVJtt1BueGuYsti5cvPWqDTsdBdQq7UJ5VfR2bKzH1pZ7NkWC80KoXoi8IOml6jS5rRD
	kZQ4okBnS2gjQKf
X-Google-Smtp-Source: AGHT+IHuLFfF12b1oVDbhAdkht6UnMmHW5RNTV1Spnouv0iBTm2A31vbOF3QNyOAqT58nf42P/2L83b0p1kTleXhIqE=
X-Received: by 2002:a53:bc8a:0:b0:635:2cdd:4ba9 with SMTP id
 956f58d0204a3-6361a8601cbmr12248636d50.34.1759126687977; Sun, 28 Sep 2025
 23:18:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929005727.18121-1-changyuan.lv@gmail.com>
In-Reply-To: <20250929005727.18121-1-changyuan.lv@gmail.com>
From: Chris Li <sparse@chrisli.org>
Date: Sun, 28 Sep 2025 23:17:56 -0700
X-Gm-Features: AS18NWCbnQRMmJcd8uYYGXHA02sObCPjI9CrvnbH3spbkvF2zDqw_BM8Sb-RcSw
Message-ID: <CACePvbUD8DLgzdRe-nBujBSN4eynRyVCYw9W9-xM-N3mqkwurA@mail.gmail.com>
Subject: Re: [PATCH] doc: update the instructions for mailing list subscription
To: Changyuan Lyu <changyuan.lv@gmail.com>
Cc: linux-sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 28, 2025 at 5:57=E2=80=AFPM Changyuan Lyu <changyuan.lv@gmail.c=
om> wrote:
>
> Majordomo commands are deprecated as per
> https://subspace.kernel.org/vger.kernel.org.html#what-happened-to-majordo=
mo.

Thanks,

Applied and pushed to sparse-dev.

Chris

>
> Signed-off-by: Changyuan Lyu <changyuan.lv@gmail.com>
> ---
>  Documentation/index.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index e29a5643..4c810787 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -56,8 +56,8 @@ You do not have to be subscribed to the list to send a =
message there.
>  Previous discussions and bug reports are available on the list
>  archives at https://marc.info/?l=3Dlinux-sparse.
>
> -To subscribe to the list, send an email with
> -``subscribe linux-sparse`` in the body to ``majordomo@vger.kernel.org``.
> +To subscribe to the list, send an email to ``linux-sparse+subscribe@vger=
.kernel.org``,
> +check `Subspace <https://subspace.kernel.org/subscribing.html>`_ for det=
ails.
>
>  Bugs can also be reported and tracked via the `Linux kernel's bugzilla f=
or sparse
>  <https://bugzilla.kernel.org/enter_bug.cgi?component=3DSparse&product=3D=
Tools>`_.
> --
> 2.50.1 (Apple Git-155)
>
