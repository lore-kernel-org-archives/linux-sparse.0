Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B812D7DEF
	for <linux-sparse@vger.kernel.org>; Fri, 20 Feb 2026 19:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771616082; cv=pass; b=a/qHLuhjEpl+KVSu+SdJvsQR6PCnYfh70SQVHx9ZkO2HtAfgl9tqXxpcjAkoWrwewLP/DFNglKihf+ixbR2ARtnNCt4SZLOU83n/AiTpjdc7HaDOZ4rxNfLuog9kqJqRkbTnNS5L0QeSyJZgm/KHQxYff2s1kuo6imv+KBiL/A4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771616082; c=relaxed/simple;
	bh=1Bcsv3Fm8OYwqLXOasgTOeKp0GPI23Bs8/zwK/Kej9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iq5uEE4Gy9S9tf1RL8HRzVdmq6VYau/zqHC5o1g3k767EuT45eIBF/VoObB5RpFtOszlwcnmGdvshU4fsd5cWH2vP8KFZUlor1YHq4WuAH8xiz8InRL3ak7PjOqRA00TGDaIyP44drGvJGGoHZLKtbbStXhn0hBgtSH0kMvR8q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64ae222d87dso2354752d50.2
        for <linux-sparse@vger.kernel.org>; Fri, 20 Feb 2026 11:34:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771616080; cv=none;
        d=google.com; s=arc-20240605;
        b=Sdgtv9l0u6AVDNYGTgGcZzCDcLta9InwgQaHncvv+RAQv3KofEfvgEvVRLWNaMY7Ii
         TIsp5Mvw+c4WDsE86KUGpD/iSFlB9RbyaJB72GP9ukgsczTbaY9KlNtBAzOr56yDlWx+
         b8/gs/+bHDHQyYklw0Rvw8lJB3WM03ZXIyQvbx4vdtQNKaV6aZusTC+7Mw7qZ+iLQd39
         XGrGHueV1YZSa2woa0YFQcdfndpIJchC98HkMIEb2Fhdz8UXb2RLUJspm0f7j1Osxdys
         BMEgJ2AAXWpQGvti5G1XkL8DrjugfHPsPGnSMtOiGyBTOcXWWtzzGqsizLopR0Tg8PTf
         hNyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=1Bcsv3Fm8OYwqLXOasgTOeKp0GPI23Bs8/zwK/Kej9M=;
        fh=v4AyOV0FpNittEqYdDqnta4F6h17/ap2q+aIphbNE50=;
        b=LNgShDzhWuKr8Q1Zzo4gcYNWpBYd+etxMj1SOmZtEclS/6B1Ey+Vy+klDO+oucQ+oV
         h7AtPsfBKPEs2xYKZA6iYKtivafirPdZLzoZGqa+FULkRefOt0YoI19gKSxjsR3wAvRl
         EybEAg8GTw6qpFE5LIdi4g7XDl50Qkvl/HxQbKJzsjpFZDiWo8IHyljkUdCG+h4J3zSv
         N8tSKDdlwCAL/HdZRtBw8WxfS/GwHqN/4Xjj94HY9p4SoHOGkFT2zbfNRgp0mf8UVt+b
         RaHpCP4s8OwsR5aKgnQaY3QYUGckPTFSxjv4gaFX92qeksMV2txQv8J5DyvHQ3+oGxAP
         ubtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771616080; x=1772220880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Bcsv3Fm8OYwqLXOasgTOeKp0GPI23Bs8/zwK/Kej9M=;
        b=Ih4UIFF6m8ZZWZeyq/DylvIMRb/KbhG2EcW9cCNHKFe11DqMmg7mfkl5pT6J2yn1df
         9n72E70IpcPeh2LvG+Sk1a+1YZ7Mwon0e58JEm3ynJIjzI5QukI5gcU8m7RKHxgT4hij
         K+vTYgWIyoRlPDeroGVsK/jjDk6A2DPgFLKzL9YlDOqOaqkSHdmEqBwxhynHS3PIYoCv
         KxKmsStHrSlD8BNaCoH8Lmg4WW2uQ6Wi5JDoJOhyIcZ8WS+HkGWrOPEHi8VjHyW/wo9p
         Kr/EN1gn60TWRdBTN54OPaki/GlT661n0cDcqwErL8dnb5qtBjImnJUoGSzILsLB1Rjb
         iJQg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ8CUa11HMlH7181/Fqw6RkxV8cdsWPzn+6TVE/xYVJvhfC7Dkdmn5VX3ry+Hg3h2cwZrNkGj3QSE7k1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzEdMnC5ZJZ98zP8YhfSVJEtxACsomFKoB5JNR4EJpxERsT6m4
	6MDiSzeuJbnC5dUnVjBnczSxYhSWXIG3rLizGx9a+Of3QRYDGehzwzN7Yut371NpZU0DoA5FO0e
	45uLAngozWKo7jRpn2Ct8kn9FJ5oFsKdmwzM7OEINSg==
X-Gm-Gg: AZuq6aIiFI3l84HoubsHoaa2xdWiIfjW7W5ESrZGd1TjTjbqvJukNTWu2BFbdLU++gP
	le0aDaLEauD9FywbnjVCDG8qiQb7CXLKyzstE8rX3U9rsO8KGsKEOKy72nfnleolajuLiLDaWfl
	57hF++4S/oqaekVW7xOSiKWT7l0Mr2TIJV+ryYE3EHuzqDckInSAAf6Xw7RwGp0UvQrkjO1NBLA
	2hqGE9Py7VHTrB248N5ZwXeIUFjImXJew1EI6gpfVcTw+Dwhkb2lRMEu0qR+SyVEGpX9xj3Q4Du
	EVY3lTi/fMSGELaKO2BcF/K89bYhLw6yXJHj96tHDu5sjfrIhKM7EySGP+3wtDNUw3/wBNW6Phx
	k/dss
X-Received: by 2002:a05:690e:d81:b0:64a:f160:2354 with SMTP id
 956f58d0204a3-64c78e5658bmr757577d50.79.1771616080205; Fri, 20 Feb 2026
 11:34:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219-fix-builtin-strlen-v1-1-3ec3efc0cda7@samsung.com>
 <CABCJKuf8jh_yxQcR1=uMeuWOueXyoM5=L-QpTuBenRi_MZK_Gg@mail.gmail.com>
 <aZdAxZR-c8PY_uEL@macos> <CACePvbU9Dh-caC59+L7wicZF+3sMjc4NC0HEkp9cVa7qqdydow@mail.gmail.com>
 <aZdighmTJN-JaijL@smile.fi.intel.com> <CACePvbWpC7o-Du=pr4Cfn-pM_XcOM1v+6cHb5mqaaEvzsvMX=Q@mail.gmail.com>
 <aZgbw40qk2zIRpbE@smile.fi.intel.com>
In-Reply-To: <aZgbw40qk2zIRpbE@smile.fi.intel.com>
From: Chris Li <sparse@chrisli.org>
Date: Fri, 20 Feb 2026 11:34:29 -0800
X-Gm-Features: AZwV_QjMrv0_Kf8LpzTob_omqayDaD81buOZ4DLJ5VxqWVmTOoHlvQpZWf0Hu7I
Message-ID: <CACePvbU5ByoP2jZZSHYWCncNNXOQXArvyWpVcinTRag8k3-GiA@mail.gmail.com>
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

On Fri, Feb 20, 2026 at 12:31=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Fri, Feb 20, 2026 at 12:06:15AM -0800, Chris Li wrote:
> > On Thu, Feb 19, 2026 at 11:20=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > >
> > > On Thu, Feb 19, 2026 at 09:06:23AM -0800, Chris Li wrote:
> > > > On Thu, Feb 19, 2026 at 9:00=E2=80=AFAM Daniel Gomez <da.gomez@kern=
el.org> wrote:
> > > > >
> > > > > Can you please take a look? If Al patch is the correct approach, =
any
> > > > > chance you can send it and fix this?
> > > >
> > > > I am asking in another thread should I pull Al's git repo instead.
> > > > There are a few good commits there.
> > >
> > > Please, pull Al's work, My colleagues and I use his version of sparse=
 for a few
> > > weeks without noticing any downsides.
> >
> > Thanks for the heads up. I just pulled Al's sparse repo.
>
> Can you also issue a new tag (say 0.6.5) so the distros can really be pus=
hed to
> update the quite outdated sparse in their repos?

Sure. I can give it a spin this weekend and keep you posted. There is
one risk on my signing key, it might be expired and I need to sort
that out.

Meanwhile, please give the current sparse repo some good tests.

Chris
