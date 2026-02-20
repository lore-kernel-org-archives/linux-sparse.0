Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED53303A18
	for <linux-sparse@vger.kernel.org>; Fri, 20 Feb 2026 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771574788; cv=pass; b=DxFM33udq6io5zOoTVQfDd2CScghz99Kh7znFkPEIqil2da5tqJbLroOuqeX23zrWx/KxN9Yq7wxKgC0F9uszwNwQkHvcOUdV7rF6ZT6DPD82MsVnK9BcOmj4HBjD54EQ9URD5vYUNJZ/W/wdQQHl+GvT1FCFbXo4qrw3D+0hHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771574788; c=relaxed/simple;
	bh=e5zleU7h447EebiFFaEjC8+LCeVuNH/6ua4IP1xwUL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uy3CS8ZLz6boQUfCvsq4BPbMFIw1j/WdKarD8a21p+6Nm4SPT76HbWxOro1Lt+HFWYnjHBrbM+RPyM68HnpwlTgpZLdQeucks3A2h18TBm+hp/dZaoOcTCvMG/lHICHbXMuiLrlgR7Xf3VGO5mtH0O6mOARfdwBoAEcjjFpsZr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64ad79df972so1785927d50.1
        for <linux-sparse@vger.kernel.org>; Fri, 20 Feb 2026 00:06:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771574786; cv=none;
        d=google.com; s=arc-20240605;
        b=e4yY0V2awn0L/CAFlK14oL3Z0ZFeuTmo3MVt0Xwu7yNcoXrQ4Z8CLHJbS8vv2Cz48f
         IdTCNv2WEH1/8H/8sBUlnNhiSqfgPoiBGFSXYA0tfLj12FvRIwg3kkOdWKInWSlwO7zZ
         Y2R8RNxixC4JMZKfA/2uttU+6Rex0DYWMFGlHS9pMt+of3XuSJlnml5AvsVU3W5l0KVn
         vVgidfoY02U+caqIPqjZ6HcH4GJuJSip/UGmIKhB8tBrJq94PG3oODqXN3JDStecxTm4
         5ZLfGDwg/o6XxurM5iCRJtyVnBywIyG7pobnj04xz9o7/vy5x64g7Q5VuLHE3L7iG0ag
         NoiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=e5zleU7h447EebiFFaEjC8+LCeVuNH/6ua4IP1xwUL8=;
        fh=oP5W9sy6Hbbe6bwgGDXDUBKeyeZ+LcAHRsxOIqiwBqU=;
        b=BWQ6bJQNixPy10xFkYWEY7jSP7oxVML4w+3y3H8d6BmStJ3iupdsKXVaQCeLuQbwYG
         jk/hvvLANS8gVs2FJ/2oczG/5LW/b/N9gIax9Lxv1/s/zQIOHSKva5FJvOTJCer3TFGl
         q8DaH2P/o6YHmDGHL6xCFlFM7f1zsgV+hn8Es1flpC+S3Dyf0a6JfddhFDxJ1P4EosLx
         GwFsb1lCVUIH9ZfogbvOXhWiu4W1kZO4SWY92BkgJJTX9llojJdV+WwOjpPFYoJwIYn4
         pIh6IJnF19mMHzj/XDOO2/Ny9EkVsNDXcEiI4YmBxYAhIMbkMwVEepCFmGhc+5eDxX8S
         N//Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771574786; x=1772179586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e5zleU7h447EebiFFaEjC8+LCeVuNH/6ua4IP1xwUL8=;
        b=EgLjXgZBHmqQDkUHKt6scxwsLbO765/u3NZOUh2+GS+d3tqpOYyeq5AuW9kNPm5gGa
         NriDjB93JmTXJFtbLPIXReorfabTltD7MmyNDi9ZrxQaJoeQ/B7JdlrJUB/7xRadrDir
         r5oh7qDhFvPXGTH6RmW1KBou1Y2StRVzN3yIoofVabM9YrqZcmpcv2p67ZDmO78N6eZ2
         pcVyS1o09p/g2GIsbYVtiIeujsZz5e0mG6covyw5Xg0t08rJViRdgRPfQ2nuQ+Jf47qQ
         E2CkWyEl3JM8upm2CtYRmQQuhTxg+Yt/I4edBMf9eeIZvbgVMcBgHZCBhSqAOBLgL7x8
         2Btg==
X-Forwarded-Encrypted: i=1; AJvYcCXfqeJhpIG0kAJr2zq6jVnYW/6MkEh5t/jVJ4c0SHuRpf60qzzdfbhUpLRNHfc+Nbfcc9jOhkFZDiEIW4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt2GUEvkUtEZUwykDiifjHKMmtXf9rER3bZXOSPnnV4l91jjL4
	QUhtEQB8BAeVU+AOzgxMzSwRmX3Q+/UWcLRnlh7TJyaJ9wzJpgupRhj0pCmLiJ6Bp0eAab3okqM
	i9vs1uGsS8+ZxXEnX4A7aSdEyNO5EJMNJipNwkgDFCw==
X-Gm-Gg: AZuq6aLNbOWexV1ruIkUVUdcTIazAj9DgHoNZux3Rs4nOs+5wdLav26XKmCK2HOZ/kK
	tLhKSMHe8ShK3XRq2A+OI+LciDGaD+iwKDo3ym9ANwVa8NuQXCaTWUBg+BxsOI1ssXC2h/KhFyr
	YMzvPIyKqUU6SqSWJP0Bz29zM2V71A09xCKMNlSt6LPMoeCpnNU7QUgHYk8qrI3vdCPc4y2E0r0
	msWkYi7jxVmjFc5cs0/UWHVq78rrWQZJMhuZcNzrCcaUxpvWU67Ot+OPG+++k+uQ/QF1J3/u7x0
	XrSGG4Oy8ywEAtDHXI7ZYil3Gy6XNmC8Wk6mbgY+OIF5KAK6
X-Received: by 2002:a05:690e:4181:b0:64a:d6a2:c6a with SMTP id
 956f58d0204a3-64c21b8d6demr13929846d50.88.1771574786424; Fri, 20 Feb 2026
 00:06:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219-fix-builtin-strlen-v1-1-3ec3efc0cda7@samsung.com>
 <CABCJKuf8jh_yxQcR1=uMeuWOueXyoM5=L-QpTuBenRi_MZK_Gg@mail.gmail.com>
 <aZdAxZR-c8PY_uEL@macos> <CACePvbU9Dh-caC59+L7wicZF+3sMjc4NC0HEkp9cVa7qqdydow@mail.gmail.com>
 <aZdighmTJN-JaijL@smile.fi.intel.com>
In-Reply-To: <aZdighmTJN-JaijL@smile.fi.intel.com>
From: Chris Li <sparse@chrisli.org>
Date: Fri, 20 Feb 2026 00:06:15 -0800
X-Gm-Features: AZwV_Qj4DeSt9QALEyytzXQrgOdJyGzDiyFU33t1N9UN_QnTfjz6H35KFosuU-U
Message-ID: <CACePvbWpC7o-Du=pr4Cfn-pM_XcOM1v+6cHb5mqaaEvzsvMX=Q@mail.gmail.com>
Subject: Re: [PATCH] builtin: mark __builtin_strlen() as integer constant expression
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Daniel Gomez <da.gomez@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Sami Tolvanen <samitolvanen@google.com>, linux-sparse@vger.kernel.org, 
	Aaron Tomlin <atomlin@atomlin.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eric Biggers <ebiggers@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	"Luck, Tony" <tony.luck@intel.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 11:20=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Feb 19, 2026 at 09:06:23AM -0800, Chris Li wrote:
> > On Thu, Feb 19, 2026 at 9:00=E2=80=AFAM Daniel Gomez <da.gomez@kernel.o=
rg> wrote:
> > >
> > > Can you please take a look? If Al patch is the correct approach, any
> > > chance you can send it and fix this?
> >
> > I am asking in another thread should I pull Al's git repo instead.
> > There are a few good commits there.
>
> Please, pull Al's work, My colleagues and I use his version of sparse for=
 a few
> weeks without noticing any downsides.

Thanks for the heads up. I just pulled Al's sparse repo.

Sorry for the delay.

Chris
