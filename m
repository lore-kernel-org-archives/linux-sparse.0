Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B902AE70
	for <linux-sparse@vger.kernel.org>; Fri, 10 Oct 2025 05:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760074401; cv=none; b=uVoBB6kOvJBjgRWzrkyfKUY65vJ2j3q3A8oqcvwt0QysIh9CBC2VQQL5vIbQDS3qJ33a0coUspH1cYc0uEDvshn2p7GSMimy16kGO7Q2hN+I6/k6ToTaIftXh65vNwJonr5DgOC6E0yNr+PYf/pxYK0ittnqds2vt2nDCS8MWG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760074401; c=relaxed/simple;
	bh=y1HWtaA0TeVTum8QxQLcJM41fexrwBUsFcg8DxjEkGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fM+dnouXQlPZLh+iWpId8eZR47vThiQLRRIak9/OT8IONwkoKlRCo3R2xQr92MOT6UbfYSXc3hxEbGpLO8o7wm6GhAnpl3m7pVUuL5bpHzB+DqPof991Pb6EMqOSPuvPw+xxHOqy3tJR1DnCc1lCrlnCcfl38PBzEURixuSx8a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; dkim=pass (2048-bit key) header.d=chrisli-org.20230601.gappssmtp.com header.i=@chrisli-org.20230601.gappssmtp.com header.b=v3IAi4ai; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chrisli-org.20230601.gappssmtp.com header.i=@chrisli-org.20230601.gappssmtp.com header.b="v3IAi4ai"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-633b45fad1aso1670213d50.3
        for <linux-sparse@vger.kernel.org>; Thu, 09 Oct 2025 22:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisli-org.20230601.gappssmtp.com; s=20230601; t=1760074398; x=1760679198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g48c48jxDw3KZkzHCh8Y8MQJWWZEAJ16ygOPNemGBdk=;
        b=v3IAi4ai2/B51oVega1MK9eVxl9yqv9SkwRgxTa509cuWGVfOgCnxGKbm3lxlKQPt8
         QJBw1U9xB/er/f+oP04i/67YwJtjK14di2w9JTTATy+gUi7T3cQNpi2yvDOvdHAwDdV1
         2Zu20Oix9Cqbf22EW7QYB4xGmF388+wpT7M1LX5r8gc+0OG87MRUswe22MldVOv3MQ4Y
         l9ruurPEI/xj1VYasgsxkwsQRaDS28Gn+bmLqMyWGQcb1VwZCFJSKWaXs1g22NcX96kI
         VUmTDV4EAv3nj2rNt/eyZD2T+s1GTD7uTf0J7tSEnzJXhXPlxJzVeHCg/XbkkZqRNjsu
         ro8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760074398; x=1760679198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g48c48jxDw3KZkzHCh8Y8MQJWWZEAJ16ygOPNemGBdk=;
        b=KenPkyfoIEvtivuYBv3LWr6802Ibkhseh+r2bkHmWwcCjr05a65vmp6MxZ17p+luQl
         Pazi+//+0PYZkxrweqXnP4QDe4cQxqL9IV8VlnayTncTc9qu+M729DWZDg+216hAd4po
         gYocdBERrXGxwdEOW5i8TramgNQ43+b/WpkRjdoU8y9ZsbEXLiS4VeV2yA1OR2b3gJ7S
         hkZ84SodLeXjpB0YpmzDXjxkxSXbZuYofKt3Xqn77u1fgTXb4pPiVP5L7Xipd39WmRzP
         pyYrSzz9N+HGJmtpNSNBFvAJdXRkK9ZzZ58/AFwysvLb1rWlDqVGkJiI1qeG8XXPgaF+
         iZ0Q==
X-Gm-Message-State: AOJu0YzkmHHjRA6NabmyzMjBo2AYxgpSLVPaINcu7+z/ZrJZv6AjcFOl
	wfiTaDV4OlY3g6UpVRtCpKJTugrF1Gb2SQEtNrfK2PVeb4gtrrPZMP2jmB7EknQCVXggun+/nTw
	ZkScckmIneuKkH9FwkOK7xtuJE9LjL7gcOcvdXkUxiw==
X-Gm-Gg: ASbGncsX4DC1IeSrdI6sUI3tcY1pbJJWHdxr/eSMIHpsFXa6pbRPMLxGx3WznYfoP20
	6FoqUHApGYcoZFYj0jvswmZtq0JBwVt3iyrDXc51mN9MpOwsNhMPxf/yaJ+6RdzNJQjfG5k0j3t
	ocS84sJAW44ZkEe+ZTrZ+tuxK+iGIYYmI9xTQA0GXrSkua0r6f8Y7a1peeRUkpIxFA4Rq63Ai22
	NWVMiALGV0VriciR5PQg0Pu
X-Google-Smtp-Source: AGHT+IG0Q+UrWP1p+AM/Ade2KHPvsDtJ1rYFnGbsS3pxqouLVvwxkkSAYoKZTreuznogUWPkDuU261RzaKy7budZaO4=
X-Received: by 2002:a53:ec8e:0:b0:635:4ecf:bdc7 with SMTP id
 956f58d0204a3-63ccb93debamr7963898d50.41.1760074398115; Thu, 09 Oct 2025
 22:33:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO=gReG3L4S90RZDTg+kx8M7jH7dG-AHKEnKJaq0OJLRfYQxug@mail.gmail.com>
In-Reply-To: <CAO=gReG3L4S90RZDTg+kx8M7jH7dG-AHKEnKJaq0OJLRfYQxug@mail.gmail.com>
From: Chris Li <cli@chrisli.org>
Date: Thu, 9 Oct 2025 22:33:06 -0700
X-Gm-Features: AS18NWCAvEydLUwwWGsTqS5luIaz01HO7jWTPC-pRV8iLecPlIEgxP-UkvT4HKs
Message-ID: <CACePvbUdWi0eGR79KFurZwEx-wEKGQJ-+gdse4hVNu-FMWVgvQ@mail.gmail.com>
Subject: Re: [PATCH smatch] smdb.py : Clarify <function> comes before <type>
 in info option
To: Amit Dhingra <mechanicalamit@gmail.com>
Cc: linux-sparse@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch is for Dan to apply on smatch, right?

Does not look like a patch for the sparse project.

Chris

On Thu, Oct 9, 2025 at 7:38=E2=80=AFAM Amit Dhingra <mechanicalamit@gmail.c=
om> wrote:
>
> Signed-off-by: Amit Dhingra <mechanicalamit@gmail.com>
> ---
>  smatch_data/db/smdb.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/smatch_data/db/smdb.py b/smatch_data/db/smdb.py
> index 29f1a339..13f1017c 100755
> --- a/smatch_data/db/smdb.py
> +++ b/smatch_data/db/smdb.py
> @@ -19,7 +19,7 @@ except sqlite3.Error as e:
>  def usage():
>      print("%s" % (sys.argv[0]))
>      print("<function> - how a function is called")
> -    print("info <type> - how a function is called, filtered by type")
> +    print("info <function> <type> - how a function is called,
> filtered by type")
>      print("return_states <function> - what a function returns")
>      print("call_tree <function> - show the call tree")
>      print("where <struct_type> <member> - where a struct member is set")
> --
> 2.51.0
>
