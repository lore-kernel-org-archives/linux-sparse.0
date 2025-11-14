Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D633451D7
	for <linux-sparse@vger.kernel.org>; Fri, 14 Nov 2025 17:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763143033; cv=none; b=p00nQPoCHXTtDU8gGbhVj+0tOA2BMVajQ2AmPN9vMRU+nGrHSAPYclpOHlfGROjB5o1dk7BHa19+LALTOMun8QupRJjcMQX8/5s/nUZPu75kUBB8qnrLUPj7vb0+uzdAKkSnefnyf0Um6J/0rLKgeYUN/B1yZSXbGKQUwoA9Pnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763143033; c=relaxed/simple;
	bh=so6p0BHVkjQUfy+5X9skc9NOHgaJ9CFjc9wu+7i/eWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S06t5yBNwhkhyFnpKpvn7MugqueTvKKymV55neC7uRs5opRDHANcN8sufEbE0QC0e1DNf2L9Nm4bXoeGKjeIeX+iBydsxggy0Fe+hHmBotl0lBjNKSroTkaJOLQZ1oXpSA3TXrj2TWXjArn0IJ4JKNl1AoBtQWudmikZJ4FyHPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XOq4Cp9u; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XOq4Cp9u"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640a3317b89so3543255a12.0
        for <linux-sparse@vger.kernel.org>; Fri, 14 Nov 2025 09:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1763143029; x=1763747829; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vNklGNQ9bRGgaodQC83USJCDTJzreS5VEwsOUbpJpVw=;
        b=XOq4Cp9u3X/dkIWJkt/EEn4iVYho+yp5+ziTnwHQkq5iJbc5K+ziK6MUz+yhha6FRM
         7HmYV7jHku5mkspyf3kXneWCGLWjTr35qt9ga1I69H3z9a/bZGNRZOHX6nEpFpo0EjzF
         sTcPtjevf3PMwTbgWo6yzQSDxTkbMnltRLh3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763143029; x=1763747829;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNklGNQ9bRGgaodQC83USJCDTJzreS5VEwsOUbpJpVw=;
        b=Zy4JToKUG3qprdRK0CpHPwjB4T/YKfnV4Rmm9ngbH8NUKa6HXiU+9XMGkNr1nomMqn
         SQO+NCxxkzCw09haBdYBGs/uHdUY/QHOpUKAbdw86x1YRogNF0IDn1IZRJqaCN23OYYN
         15sBUU25EmG/mmoHC/+mOABJuV1MNlfqmthPyCmxu97JatGUyuPQN70ir+CJNOEWYwdr
         OKpcxzqYZKvJyrbRtLMxyrV7ItNPoY2C6Z7Jv93pVAINvRCNfGb+eAbMofdrJuW9Ppwl
         IkNCyXfkZOMfuZWA/Lp6s3oF3AYZ3gzJht+6/Mqcnck0LxQAXiXXtWOE1c+rDCvp4wcS
         qpvg==
X-Forwarded-Encrypted: i=1; AJvYcCW44JcPgI0jUtJH7aEGNnUM0dHX2TpGP9HxYwKEi2x9QU19+kH6gamXCk8OOs9KqRdI5K2fuYEKlNXdYXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7EWBRRgzqU1ZOhSptkoxFJ3gAs3iapntFcCEqYoxA4E5IoNRq
	oCMgNNqIkGaTRwLGmOsXBt9y8myzwSqO/qrLp8eqMulboeo3+zed7yNwKE2Agu5cpbgRI565l6A
	2iK94xmk=
X-Gm-Gg: ASbGnct3sigVFvMgt/tPjFRRltyFcWDYNhEmByEVeC9/xy06TpZzSTgPuK4yiYtzo+U
	raG71k5GZjFEwZBgdq9jJk4Y/6hkHZ7IS+cpK0jWx1l4NgQ1y1ZT5OzPulHNzhEjqqCHgLQnSpg
	hnEyj6WMRISeGJg2IPmUWE/gcZjlzzwXSn42ROO6zyy9UBCWgeocP/bYjErFSK1W+zB0eSQbx+4
	gmu9BAyV3uQW6eHyl/i+DB6f0YabnkpN+2UqKgU5ElRPlxk7EtnktN+rexbPlhnYhlvnHibT/bX
	R1bRZ85/jFh3a3+Y6sGFhqFdKzVTxzYgwPK7i152Vq7Z3H5xj9SNc7PYxVa5S/cvojsf8tMKy+/
	vhgL+8XxjT7kBlkVj0iNDi/rRFWonyZYP+9jTUD7z/6sflkGKWA1MbdplvUNUIomAAtQH0dT9HQ
	JW411yKftY1vZLJ93gPP6TGi9H02PsKdfPHw8DLPdkO46ZgzPQlw==
X-Google-Smtp-Source: AGHT+IEiLo5OAI/s5I0+sYkUt/Q3x0eIeDWqPlpBEp6Lbdnqt3NuwfmZp1T1TVunxCXfRjvXymwt+g==
X-Received: by 2002:a17:907:3f25:b0:b6d:51f1:beee with SMTP id a640c23a62f3a-b7367c33967mr313214066b.0.1763143029273;
        Fri, 14 Nov 2025 09:57:09 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fedb2eesm427297466b.68.2025.11.14.09.57.07
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 09:57:07 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b725ead5800so282064966b.1
        for <linux-sparse@vger.kernel.org>; Fri, 14 Nov 2025 09:57:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUoWye2cm/AvhycxwAO3i4iDXrW09hf4V1s7p/RcC6Q8yfCeQQWRXDk+wsXCZFS78NQKvFHeomcpnGKyWA=@vger.kernel.org
X-Received: by 2002:a17:907:a4c:b0:b73:594e:1c47 with SMTP id
 a640c23a62f3a-b7367829b07mr457884466b.26.1763143027209; Fri, 14 Nov 2025
 09:57:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114055249.1517520-1-hch@lst.de>
In-Reply-To: <20251114055249.1517520-1-hch@lst.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 14 Nov 2025 09:56:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg=B_E6xyFWF0s2mGrRP==7Oo9WAt645x6n+Fb2FAWNjw@mail.gmail.com>
X-Gm-Features: AWmQ_bkAygS1m4gIrLP85OuFDxKOwq2g5_BcgKz10fXDRtXdYrbuz2oWG7iLQkk
Message-ID: <CAHk-=wg=B_E6xyFWF0s2mGrRP==7Oo9WAt645x6n+Fb2FAWNjw@mail.gmail.com>
Subject: Re: make xfs sparse-warning free
To: Christoph Hellwig <hch@lst.de>
Cc: Carlos Maiolino <cem@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Chris Li <sparse@chrisli.org>, 
	linux-sparse@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Nov 2025 at 21:54, Christoph Hellwig <hch@lst.de> wrote:
>
> this series isn't really a series, but a collection of two very different
> patches toward the result of having no sparse warnings for fs/xfs/.

So I answered the wrong email (because I saw the other email first).

I think making it sparse-clean is obviously good, but as mentioned in
the other email, I think the clang context tracking is the (near)
future when it comes to static help in lock context tracking.

I know you looked at that clang context thing earlier, and assumed
that that is what triggered this work in the first place?

Anyway, iirc Chris Li already at some point indicated that he'd rather
remove the sparse context checking entirely than try to make it
smarter.

I do think that being sparse-clean for the current sparse context
tracking is a "good thing", but not really because it makes sparse
happy: it's a good thing mainly because *if* you can do it, it tends
to mean that the lock context rules are really simple and
straightforward, because sparse just doesn't do anything non-simple
very well in this area.

So when you say about patch 2:

> I actually think this improves the code, so I think this should go into
> the XFS tree.

I heartily agree. But then

> Patch 3 duplicates some XFS code to work around the lock context tracking,
> but I think it is pretty silly.

makes me go "if you have to make the code worse to make sparse happy,
maybe just look at the clang context tracking instead?"

Because I *assume* that the more complete clang context tracking
series doesn't need that?

            Linus
