Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902F5281520
	for <linux-sparse@vger.kernel.org>; Fri, 10 Oct 2025 10:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760091583; cv=none; b=E1hqSvQQZTo4fknTmnJgVmfeOoAMLgZxb1odUTnwU5q+5CMJPyXpdE8yu7o3J088ZALmDcEfti3SVXg+HYU5qAhymDMGE/QX07Un+q99N1koPOGPM1yj3GK1UcJM6peKgYp91FhQQ36x1cBiku4yOnW36VlZNijdKCNujfBg01E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760091583; c=relaxed/simple;
	bh=vQTcrkP25BivkulkT98cIgGgXXLIhnG5IxMwm8dLdoM=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aNEaqw+aFP+eL7+8xqmwbamQR6eZOfbUEBdcmORJT2qXoKF7EOxkKI81KNoTNzQWZEYWQDVO+f5pGuMRutUnyaVQtKhl5qUd27AeYDBhIl+oLn3gc996fBpSe46W4gBoLltJ+wttxyMybhUqWqdAJIDyXDKIjd4AmbpiW0kZ7Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUzQsLdq; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUzQsLdq"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4e4f8122660so19544011cf.0
        for <linux-sparse@vger.kernel.org>; Fri, 10 Oct 2025 03:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760091580; x=1760696380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EM9Qarrpss/woYJydK/qc7TA3XubZ+CCF4EV53cenCo=;
        b=eUzQsLdqgViTLztClMCZzOSnJgXby7f0D43HBaGmKBDp3aAUarKfTH00fw6SUfTwcU
         Ka3DFpTpI7RPU6aIoVuGe2aZotDRXSm/ZiTHYkbvBDqWC8SGdV9b3nUqUjgFs/4ungWb
         US38/lLw7XHvhrpLK5NUfp9QQ++mmuajV/sn6ktUS7Z1ktzax61a2ztXxprm2ZO+GsGM
         4MNkP0F5bzcCgG5wQRN4RQIIIk6rf7oyXaI+6LBDcqJ/BrhIjE3WsW1eeCI9NFrMkxtM
         B76BvnomQO3XPZwWBYG/WhzevPmTlpgBR/2rHFeXUhGtnr1lCThoyw59RLmWm4AsogQi
         zaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760091580; x=1760696380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EM9Qarrpss/woYJydK/qc7TA3XubZ+CCF4EV53cenCo=;
        b=cohHGQYNLhpeuza7JXL8Ztr3IkR/bVRIIHgNbZ1sKnl5aMgEYtQxpaLVxi69D3n1A8
         Bpw1MdzxpARrmMYqecrR5+C/NY5V6ZqaaFYIT/FCP664q3qPkgyBU0DZaef8CDTnUuJ8
         7UkEyzaX7T+X4e9mcDDC/C3ACnXIJEXZ8M3femNT9V3sdutd7+YZIHFjCYowc9sHGVQ1
         GGCXzXdMSOaCTvRZZomkO0IF4YWC2+zLv65pAZXtKiwQXNAQAvfHQBb95Od8aOi2LMaW
         9wJbYiT+lpReYDN1yrXbrtNF0uBTzVfNZLjwZrELgp9OVebTUTArvXQiKLe9M0SJk8EA
         C34A==
X-Gm-Message-State: AOJu0YzTc0njvRAFNhRAa6FEuB6LvS0ioXw+7icTTjJw5ch+nPnu4EXt
	F7zETP191M2llhJo70E4IcDstu/eBt/22z8CiiWpMFmLo8JBT0kLBBt746W/vYuszE+DJIYteLN
	RR75d4w4kt3JZmx7116hI9MRJ1h/dnVw=
X-Gm-Gg: ASbGncsJnGDu5OwRdFaaovyweLr91WV1BYgrh7McS9Hd0SoQnhJfaypIr9iuRnwOP8g
	IcBAB1QqVmgygdKl97qtrxNAX+18j4P9LFzpkrEw1p4gthf5Rjrg5zv5tevEfjWMEI8gzgYYueX
	bpXkzbGU8V7CZ3YN0AN1UyLOILbxPa9zH0vAsSkdxocJ+Z0FstiDnsVtn0nMVqp8OL7Z9EJtxHR
	pnGBpwf92t7P7K6KJNYOeNbqIw6NpXvfA==
X-Google-Smtp-Source: AGHT+IHroLMCtCqgkVqm7Jn/7Wani2kNNTuY7eleY5A+HwSj1V/A1WKihn5nAXp6agwZ8ZJ2r6Cv4tsKMeRjt9hyxVw=
X-Received: by 2002:ac8:5d06:0:b0:4db:c913:ac6f with SMTP id
 d75a77b69052e-4e6eacfbd5bmr139330171cf.34.1760091580471; Fri, 10 Oct 2025
 03:19:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 Oct 2025 03:19:39 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 Oct 2025 03:19:39 -0700
From: Amit Dhingra <mechanicalamit@gmail.com>
References: <CAO=gReG3L4S90RZDTg+kx8M7jH7dG-AHKEnKJaq0OJLRfYQxug@mail.gmail.com>
 <CACePvbUdWi0eGR79KFurZwEx-wEKGQJ-+gdse4hVNu-FMWVgvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CACePvbUdWi0eGR79KFurZwEx-wEKGQJ-+gdse4hVNu-FMWVgvQ@mail.gmail.com>
Date: Fri, 10 Oct 2025 03:19:39 -0700
X-Gm-Features: AS18NWA5u9KqQ-Y9bZOmHimhDe_1Feln36NjyiQdrX1egTFPjtpqf3teGjsBugg
Message-ID: <CAO=gReFB+iUq1ZBdwWsZfqtEGosmmmcraze7gC=T=ZERDT8tNA@mail.gmail.com>
Subject: Re: [PATCH smatch] smdb.py : Clarify <function> comes before <type>
 in info option
To: Chris Li <cli@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2025 at 10:33:06PM -0700, Chris Li wrote:
> This patch is for Dan to apply on smatch, right?
>
Yes, this is for Smatch.
My apologies if the list is the incorrect place to send smatch patches.

> Does not look like a patch for the sparse project.
>
> Chris
>
> On Thu, Oct 9, 2025 at 7:38=E2=80=AFAM Amit Dhingra <mechanicalamit@gmail=
.com> wrote:
> >
> > Signed-off-by: Amit Dhingra <mechanicalamit@gmail.com>
> > ---
> >  smatch_data/db/smdb.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/smatch_data/db/smdb.py b/smatch_data/db/smdb.py
> > index 29f1a339..13f1017c 100755
> > --- a/smatch_data/db/smdb.py
> > +++ b/smatch_data/db/smdb.py
> > @@ -19,7 +19,7 @@ except sqlite3.Error as e:
> >  def usage():
> >      print("%s" % (sys.argv[0]))
> >      print("<function> - how a function is called")
> > -    print("info <type> - how a function is called, filtered by type")
> > +    print("info <function> <type> - how a function is called,
> > filtered by type")
> >      print("return_states <function> - what a function returns")
> >      print("call_tree <function> - show the call tree")
> >      print("where <struct_type> <member> - where a struct member is set=
")
> > --
> > 2.51.0
> >
