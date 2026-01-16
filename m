Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9092D8364
	for <linux-sparse@vger.kernel.org>; Fri, 16 Jan 2026 23:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768606307; cv=pass; b=nACiM/FjmvC2SqSB8SsMFBOYOSm4vyxIex6Wje7sI/WG2yEb8Q3/QZHgVO8nIMt2BbmJmwTRDl3N4cIp31V79Zsdjb0noGwbAWUbhBXcGX06xqP7QMOEBScXh1j8uVHVNCPOkx20LMR/ZvvJzZbFj2Wu7sAtIo17LxEaV0UqRI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768606307; c=relaxed/simple;
	bh=lEwXwLPdEEr8vRExQCImRDLhD1elclpYiA4Dx59RpmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0dbHe0N0o+JlLtfu4esD2e1XbDP1YuCbUT7WTF+gHIly0YB+jJyg5MgrCpACBLuZWDZOGWenoZbrJ/FqGjaFCRG0K5bp6nCMGd3J6Ls9BLffQI7tnRJx5kr2K7+kUMZkWJldILqF43xEKUxpUVvpltyxcUAHq/asS+AfnzZfKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-78fc0f33998so24829887b3.0
        for <linux-sparse@vger.kernel.org>; Fri, 16 Jan 2026 15:31:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768606301; cv=none;
        d=google.com; s=arc-20240605;
        b=fMiCqn/BGPtgPRHnYC/IAPE5srgDA6hGY0lUW9Sr7h2tQq8HDW9MHOnmYOJnmcooIQ
         jEOTDX3E52d7H/Y3x3PZsBOe3T4A6HVUnd1M0KribldkFbJYRufE2rRz0pfWcFCmVOjw
         d0cM1xNviJw0dFpfA2pIaYK4RbWrgEslP45duH8pUTzlNlNuewqjWjgqCboMItQSnzTA
         qNDT5mACU+cLTOdvP8hLXwfPAgQx16A6u9HlyAK9IcEXsYUsi0uann8vLlXC0YIkkVTe
         /D5q+oFAAZlyeKg7kHdrFpoSik7snzYFnmvOCMtVHOol0ho4FLpDX66kzermZOx0I4bA
         OHYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=j2yPGquDDo/a0G7vj6dAli2KD97oUaI3w9qOlOVbP4k=;
        fh=/0LOF2E2fVFDTWhHXF1V08WvKOGVWkYBMMBmDje3smo=;
        b=d2TQu5WLC4G8+VoUKrdRGKXBBqWc99X0ms7RUZcaLmnVPofF6lK6wzFecX5oBZuHVa
         PjWehsBByVG2j5nrP5t6P0qrJhoWZTl076kEC6yyuYQvcZEqXE9iNHNzV8Ab6ZfPnxqx
         M3gD1QR4qRTJ7xeJ27C/HteTJp/ZUKkAYOsHhJndAje1J8Bew6kdNiiW57Vfew+zqOpC
         3J5ziTFV7m7D401zsXIARZuV0kiXhK9HR5FEROlOOojkNX6VHYPhOuDhh9xNExPiG3ar
         9hvsX/++MZkuKw4o6OygeYuu2NQiwbcYmvNZJj5zBqOCTHVcrajOgz20RDMq9u2UkvZA
         gt+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768606301; x=1769211101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j2yPGquDDo/a0G7vj6dAli2KD97oUaI3w9qOlOVbP4k=;
        b=eBJW6LFKSJMPpxtcm3ddp+UR74FsqjAtYZ88EzSEN8Or2HbZ0zAfJOntSusbo8zI2l
         vQ9tVl0NHC7wsIq8Gds6CsMFZnYIBpR6j9ONyjZT8LBVarb/Fm6v3tjFU6qqlttfIStW
         vkt01kEeNe5ehSZ+/KBx6gNzANN1fCPNH+MagqGAAaiib4SWOpTyrepNd4JQHRGArBvx
         zVJYg5xxWk+lhKdnAe8N2hMuphyKvF76HHxhqJQZg0lofqqnZiheYYEqUqAC+70DKzOG
         hIfHU5fbxXROvAgqktZvRxfGqPfDgyKysDDoc4rwk4hStR7eaaXtJm/DynZ2buRcK7Pf
         Z0VA==
X-Forwarded-Encrypted: i=1; AJvYcCXv9Pjr9PBvrTC7c2uxdzC7MnZ+BK3GdAh61qDHWJ58PNUEU19ficPgyPRTGxYniVcJAHoeL9hI9g2N+KU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOMmWScDWXOYs4zM4G4W7+mmMordjpA1iUiJkPH6RRZffR21Rx
	OvCJYIA6BwQGK1vJ253mIRUTdCDLB/sb9RvFwBjgtQA91wWSzaXbnmYbxe6hsl4nkzXSqeImqd0
	d01uQufZOSc2zWmxYDa8t7yqEPFRtD0bfA0YqQz/a9QTxtkXg0zC3
X-Gm-Gg: AY/fxX6SiT5/IPJ3W+twXzA1wH40/j2bXs17imMtu/q+CHIb2fEXubTN4s/dO8sPSr9
	yqHXnoxCoamSit1PFsgRoC40s3a/xKR9dcSR1SCFPppPOSqwppoGiqsEMXLp5TIOeFHtpbjW5Qf
	QxVlGwGcks5jKvopuiaUi5D9T1+Q2BpQl393C3iVtDzob0vFDi7czeZOrdpYMl14Pnyo1deL53s
	C/5wnw22+7uXGolJxWRCLtF91f3aqlJf+vRQo+bY1c0dAzKEGcdacvTntv91YVP2spD2YodSfdV
	lYkmtBtyNxhMCf+bvan8O1inF1sO44knIk4Y/cz4VYONSfTRkLpMsH43TQ==
X-Received: by 2002:a05:690c:6b85:b0:786:62bb:f6f5 with SMTP id
 00721157ae682-793c52686d1mr80908347b3.17.1768606301042; Fri, 16 Jan 2026
 15:31:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218060921.995516-1-rdunlap@infradead.org>
In-Reply-To: <20251218060921.995516-1-rdunlap@infradead.org>
From: Chris Li <sparse@chrisli.org>
Date: Fri, 16 Jan 2026 15:31:30 -0800
X-Gm-Features: AZwV_QiZ6mOuarjS8muO7KegbO029hGFzUfOeno9n_1LC9hnuZW8xIHhkx_l6m4
Message-ID: <CACePvbVNiWKOHxT0GAtFUp7QcP7t43RZnZR75yM_SR28a6TNvA@mail.gmail.com>
Subject: Re: [PATCH] sparse: update MAINTAINERS info.
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	linux-sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Chris LI <sparse@chrisli.org>

Chris

On Wed, Dec 17, 2025 at 10:09=E2=80=AFPM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
> Chris Li is back as sparse maintainer.
>
> See https://git.kernel.org/pub/scm/devel/sparse/sparse.git/commit/?id=3D6=
7f0a03cee4637e495151c48a02be642a158cbbb
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Chris Li <sparse@chrisli.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-sparse@vger.kernel.org
> ---
>  MAINTAINERS |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-next-20251217.orig/MAINTAINERS
> +++ linux-next-20251217/MAINTAINERS
> @@ -24595,7 +24595,7 @@ F:      drivers/tty/vcc.c
>  F:     include/linux/sunserialcore.h
>
>  SPARSE CHECKER
> -M:     "Luc Van Oostenryck" <luc.vanoostenryck@gmail.com>
> +M:     Chris Li <sparse@chrisli.org>
>  L:     linux-sparse@vger.kernel.org
>  S:     Maintained
>  W:     https://sparse.docs.kernel.org/
