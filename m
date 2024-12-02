Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0251DEFE8
	for <linux-sparse@vger.kernel.org>; Mon,  2 Dec 2024 21:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733173598; cv=none; b=OVLcvZIFAWA9dTZn8lLu94S42CADSzRBNyNveF0a4ETmSYvnZbS9S9fGEA3jemt3ad/w0AKsWRAa581RLSgg4AUeCGD5rmdoFn946c0IRy+BEaWede3JBi7nFuwaA+5Vt+9oY/PFeLBL4ylLLWeh19LQxEAvQbVhI7ZU7Nt4kt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733173598; c=relaxed/simple;
	bh=RvjCtzdKVrvbWKQVEXYdBnVvywPTYiArckHNQkEptzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFp0Rfg9Zea864MP5MFw484C+IJH3drxrGlHWHyhIQerzrOWbkAceRC1aiom71zKek/TeJy9Ym9JL+7EBqM0Fvo1iDSfyivzDfD2gl7lBM+09fyhSEbQ7ji6BhdOl/CkqkePKWA8BZS7kLwKIHoWbqHyCKbx+/F2vBI5wJQUaOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EcrO95W/; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EcrO95W/"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d0ca0f67b6so3636533a12.3
        for <linux-sparse@vger.kernel.org>; Mon, 02 Dec 2024 13:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733173594; x=1733778394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WcndBrbpWuoHMnsxtz9P9A5nq/oNeq0He/lm65PwFU=;
        b=EcrO95W/pz3xLhSr47lJqxCofSNBCSAm66L6d0h2s8Z9BddPr5vIDmvY+Pj/h70F4W
         8U+rCBlxvkbhCs+stI2R//1mej6NM2NiTzthvKlvqG4KlNVlIjLRmLnjoZ/+JoWSg4pH
         y1kek0b1jdZjySw2nQfQCJvQxvRDo2vT84wPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733173594; x=1733778394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WcndBrbpWuoHMnsxtz9P9A5nq/oNeq0He/lm65PwFU=;
        b=VckIlC/T75WssOScHrgS0U4MIcp0/EThX1vSg0CvT2kydMaPpPVjfXFvCRB28EC9Ou
         ax+jSdOKF8S330m2vtd1sm0DCtG1FQx7uUg4hD6CgD6z/Z9h+vuIkMlWpzNv2o3RHfpv
         1eq9tzkTYVDv0UDjusPyLcfhy/Kf9i0t7w37EULE5hsyJfuN8tU8pke9hZCC21aL83DE
         OXZREdOnPZChOuclahmy5/0jILzIS2wlCZxEO3VsgM1XdEb1wLqbWI392yE8T/xuh220
         t2qRc2H/FeV5nUo1k6+kg4aGnV6D37WYq0pZBYvd8B3Cwywxl7zyV8yxRSnXuOQ00/yn
         3bkQ==
X-Gm-Message-State: AOJu0Yw+/ALVpXD3B78ubPcP+Sle09DcoEs4TPY39W0Kg03ZRyAArYwR
	clMhIeNHVZxWkA+cb7ibGPBzI5JQIPBXi8qUOLe68GVwPD0Sp7IkENH6CIklEFFKVWjY+5yxIIo
	0hypbuA==
X-Gm-Gg: ASbGncudQh7acwot5FWBV76cFBEkVCrWfLrAUOKTd5To4RQix+psf/luI91CGr/14JS
	PYAsBli73JVPJJA+Ex4YSQgoTek0MoJMbKhH+k1xzWV9bqUtxiAq2sficSmRtXge3BAgJ0E2W5I
	P0uWcMLZDvH0z9sOgG3KZFkS6wFpy6YKJmspAXJlI/OoF51H0FMhcA2Yk7lJR5f1JLnK/v/ANNf
	1ptUs2ER2KSBovXTXf5EuFETG0jMpy9wTPfUFcM98OScaTlom/qVvx8fteeLDhVf0dc3DZIDKgi
	Xn0JLBYT/MPBzu1CpDvshkHR
X-Google-Smtp-Source: AGHT+IFLnTWfKV0MFG64Ll/Yy1qAP+wCceJSwDEa269/vUj/85gHBQTVQ9weBBXpmEjTyweABHIdog==
X-Received: by 2002:aa7:cfc3:0:b0:5d0:f6ed:4cb0 with SMTP id 4fb4d7f45d1cf-5d0f6ed4e48mr3592536a12.1.1733173593848;
        Mon, 02 Dec 2024 13:06:33 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0eb2d116csm1596371a12.61.2024.12.02.13.06.31
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 13:06:32 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d0cd67766aso3451455a12.2
        for <linux-sparse@vger.kernel.org>; Mon, 02 Dec 2024 13:06:31 -0800 (PST)
X-Received: by 2002:a17:907:cc01:b0:a9a:a891:b43e with SMTP id
 a640c23a62f3a-aa581081adfmr1938344366b.50.1733173591318; Mon, 02 Dec 2024
 13:06:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xc3xx56vvesaen7r2c3q5thmrjva7zcfq5habasejlyn7vnpbj@jxsfprt5gfa4>
In-Reply-To: <xc3xx56vvesaen7r2c3q5thmrjva7zcfq5habasejlyn7vnpbj@jxsfprt5gfa4>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Dec 2024 13:06:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiVDZejo_1BhOaR33qb=pny7sWnYtP4JUbRTXkXCkW6jA@mail.gmail.com>
Message-ID: <CAHk-=wiVDZejo_1BhOaR33qb=pny7sWnYtP4JUbRTXkXCkW6jA@mail.gmail.com>
Subject: Re: sparse reports "different lock contexts for basic block" when
 using guard syntax
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Dec 2024 at 01:26, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Trying to understand what sparse wants to tell me, I tried the following
> change and the 2nd warning goes away:

Sparse really doesn't understand the new guard infrastructure. It gets
_parsed_, but that's just about it.

So it parses the cleanup function, but never actually generates the
logic to _call_ the cleanup function when the variable goes out of
scope.

Which obviously then means that none of the context updates of the
cleanup get done, and so the lock context never gets undone.

Sadly, I think sparse is unmaintained these days,

               Linus
