Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B7331AF2F
	for <linux-sparse@vger.kernel.org>; Thu, 16 Oct 2025 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616317; cv=none; b=cXuf7wM/mL2buteP6aNmKd+im51MNDjkIzcxsb9AESKfwVUMNmyeetVzBOaQbVSfA1WN2NVaZ25XW+8YIB7F132zolN7PgUJ8rUTO7bimKOZ1vqr7GReRAsj5k2Usw5ci+YERJGnPN95PnOAnWgpzwMNeX111srbOfkzU1wWdpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616317; c=relaxed/simple;
	bh=GqAKJK54/uF+NFRmildYJfAKhtlHFPU56asZDkSU5Rc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fj2Dgj55raB13YMREVJRTQEu5XImDWqRQOT0KVSbuNWlBtiyHnbYIb5Sn/upjWjnpZJyWCNQgOBCsSJkRAAPl9liIyLJzWt4M7Gw5+HWnOUggnKmXFAtDBBcyXrYyoQBi8zecYtjVO5UwF43U5U/Hrgrl9WRNyFZTYc5uiwZ2yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6354f14b881so488850d50.3
        for <linux-sparse@vger.kernel.org>; Thu, 16 Oct 2025 05:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760616315; x=1761221115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6NCNp1v7fwHDK6nw1lwRkEI5nN2DLkyaDuxO07PW0g=;
        b=oH/VowQvY+PU8VHp+0IqAYexf1UNA5jTYLlRvJVoK/Xxn3/ipDR6rRqjAL1imOjTcP
         3SuIzsf+K2AWNMWNwceN2piqCG8KKX+BXqtaJ+07XWq/PpgWlHVxmsXR7eweSF9037dr
         vSTI/f/KDaJZdfgAn0IG2unQoeTXPC0Wz9QTRqiAu+kjJV2k5Aw4hkOcOn97UjBsU7Do
         QD9D8tEEh3l9YWX9LC7e31Ei4RTxnsCWjWdqQg2t9Ue3jdZWcX4gZ3CONZXPbkx3CV7A
         UGbBjE4tRX03D1E3gF5rVffTJoaQJH/mFh0KvdghNbP6VCFKpIQVfGMSDFreYylWhpw8
         lrrA==
X-Forwarded-Encrypted: i=1; AJvYcCW/SZGjQiHB5EyxXxEAxUiuHRj9CchTfeeiuSRyrmnitLyRTkNBTXC8Qz42cK0vj7zgl23ffBqdh6FaJPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz2SSri5iUczJht2wpkaca8rrVN6VkdN8mpYrNRv7idaDLfpT+
	6oLMn8HHX9yesBSIg3H/YsmBgg2WuGB8KJCDJcvFDhDzhkS474rRtgQ5cwZZbmDlrUUj+z1mLjb
	jUH1ipqTqVqRgI+efWSz0ng9oHmHqOdzV0QiEcBHOJ7VLGXWVI1KqNqs=
X-Gm-Gg: ASbGnctAqENY8DRnPwZWnMS15xW5Ffr7mIF4ZXAbysRFqPCZPOwc9+9cndNyTSpDg6o
	PfnmogdLA9+CrWu14T8bA0BrzOK8xRShIOnV7LWrJ72+fCSgWeXj4NH8XoYppPuhajGZHzl/RQ7
	I2f6S8MRyCwyIo+i39ncm2Vv30gF3F2TEqEG1Ur55KX3QVbdf82u/RqwMMCN6MUp0fDVPetxdgX
	chPguiv3XFSf0WvzVlGIKrApnaY3Y3xCvyrBjEjlWQQKihUgiCAdFCZOAYI92c58DRxHw==
X-Google-Smtp-Source: AGHT+IEqVxED2LHwKa8sHNu/CN44BShEryScj0XS4qcB8mvl4A1/yCPvdGkXOwqINTlZjAL52MfgRJ2BTryRGWdFYJo=
X-Received: by 2002:a53:cd86:0:b0:63b:fcf:5c5c with SMTP id
 956f58d0204a3-63ccb817b33mr19824859d50.11.1760616314784; Thu, 16 Oct 2025
 05:05:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aO-cvXncl7dbnP_J@stanley.mountain> <CAHk-=wgKcf_dP0_7yTqL+JKc03mhFgqFHkN7jXLUrOy=WjWZUA@mail.gmail.com>
 <aPCs46Sno0a4dsyK@stanley.mountain>
In-Reply-To: <aPCs46Sno0a4dsyK@stanley.mountain>
From: Chris Li <sparse@chrisli.org>
Date: Thu, 16 Oct 2025 05:05:03 -0700
X-Gm-Features: AS18NWBv29VoayyVCgViVyockHfO_SFhnGOSkLe-qT_2MjboIajTGEGKPRI-1UE
Message-ID: <CACePvbVG2KrGQq4cNKV=wbO5h=jp3M0RO1SdfX8kV4OukjPG8A@mail.gmail.com>
Subject: Re: [PATCH] builtin: implement __builtin_strlen() for constants
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-sparse@vger.kernel.org, 
	Ricardo Ribalda <ribalda@chromium.org>, Kees Cook <kees@kernel.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks,

Will apply with Linus' fix up.

Chris

On Thu, Oct 16, 2025 at 1:29=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Wed, Oct 15, 2025 at 08:13:51AM -0700, Linus Torvalds wrote:
> > So you should add a
> >
> >     #include <string.h>
> >
> > at the top, and do something like
> >
> > -       expr->value =3D arg->string->length - 1;
> > +       expr->value =3D strlen(arg->string->data);
> >
> > in there instead, because constant strings can have embedded NUL charac=
ters.
> >
> >            Linus
>
> Ah.  Thanks.
>
> regards,
> dan carpenter
>
