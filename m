Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536942264C6
	for <linux-sparse@vger.kernel.org>; Wed, 24 Sep 2025 07:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758697453; cv=none; b=DXSJehZfVq8lBleRFSGwgZ5VWn5wq/pZZT9FwU9mcYGvB+nLEUvvNZn3evbxLG81NT9UPcNm3YsDKl+nsNlBnnd0/MiKZ8Uh3uRI1AKD2fNFFe0zppI9mNg1RRhAXFSTI2nRmEYW/RauqeemHclBtF5jfuiQCPK11/VvCB1rMks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758697453; c=relaxed/simple;
	bh=+wFDFu3X0IeD93/B6+ckaz1Esc9d5W53E7TSgB0I5LA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ausTd5/AVZtsIWm9wkPRfVrAiO25SfSBShis+6Hi0W3/LvpHilHhx9GCzJAyt2nXve8TOlj+j2o5ir1Z5RBRrtnoqhvTRKL3kwy6VveB9fF5VVMAH/Peyrnn1EoITw3cTPKkMcoKF/EwcJwY8ZTrba+GxVa+oVCczsAUSTvBjWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-eb3671a7db4so830605276.0
        for <linux-sparse@vger.kernel.org>; Wed, 24 Sep 2025 00:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758697450; x=1759302250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wFDFu3X0IeD93/B6+ckaz1Esc9d5W53E7TSgB0I5LA=;
        b=SL12tkCO/Sr193ue7EQDB1tr4tggQhuco8u2UZfKhP/RobitteabMREXo6pfp4Kk+o
         JO4L4U/z9gU3BBYqb9ZOMomC/4VNlAp7LxCJyxgzTe5txLf2FCmk4+N8W/zysax1PiKY
         IncKI+PtC3MYzaJjW3Im5yZqZl4L8k3W4h3KpXoay/RuxIPpMMJpFUb68zjxfD/FePTv
         kw4RDKuv6M6e3rK6ue456rGHepGXy/fXwQ8qAJNVHRFcVxh8xmlSXpIlvpFgGkkcRlhu
         l5KquRVTW481oNtTDXr/lG1s/+kQFLxjXbVVzRfcz57W1BuzWkbTMzYuxqbXK3zpFzYr
         dVBg==
X-Gm-Message-State: AOJu0Yz0HWyAGhVOwi9CN5PInmQXnDJg4zH1GsLIQvrWJpAwwfzBepxD
	CdZA3O3kYRtbFCV4IOa+P/xQxsQy8WZQ2Z4sz6EPe5DDa9hN/VK0rwDuCwdGlkuIUhTxW5bBYeY
	yOBWq/N8J6yPsUfafcbnTlMkdDCMUmCHZ62rB71Y7aY9Q3W3QBwQPfUIJWw==
X-Gm-Gg: ASbGnctMAopkHQr69+zIYQSNOaIuheHDEP7hUCm3DFDhYM/JaGtWt/gnWQ/xJ78nfo/
	s/2cbL30nDtkleqe2hdVvgjHo2yj21BaE6XleeY5JiXtJPda0p/YpPk0zQUAJR+Tnb6j1IMtYJO
	AvR3Vc40tE34gh4AaPqAdRSxQlvPgzBuG+58ibis7w9HyZYKaIJt4eanlVFqxMK26Ea2vqUD6qk
	O0gwOLgX0AQsDuh
X-Google-Smtp-Source: AGHT+IHTmbxtqAtYLYq3kSHcXzAAuoWtWMyMHaKDhi5yBzUK7Qei9nZz41KEUgnm4GdZBngSR0/WCF9f8MD9lK2OoKA=
X-Received: by 2002:a05:6902:20c4:b0:ea5:beca:730 with SMTP id
 3f1490d57ef6-eb372cf543dmr962774276.9.1758697450152; Wed, 24 Sep 2025
 00:04:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACePvbWQVBNQAAreW-Mzkp8ircGtV+K=gNk39HmUC0TNDOBCwQ@mail.gmail.com>
 <20250922155415.3289196-1-mailhol@kernel.org>
In-Reply-To: <20250922155415.3289196-1-mailhol@kernel.org>
From: Chris Li <sparse@chrisli.org>
Date: Wed, 24 Sep 2025 00:03:57 -0700
X-Gm-Features: AS18NWBwRixu3L2A852ErElXKaUV3ShSfzrXYqmUFZXbkD1g6m-VrvtzNIxWHCk
Message-ID: <CACePvbXaHKH5Vp+j53pk6494pgDEABQpZ_gOo9_nmCZ4gjxUHw@mail.gmail.com>
Subject: Re: [PATCH] vadidation: add used-to-be-signed unit tests
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-sparse@vger.kernel.org, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 8:54=E2=80=AFAM Vincent Mailhol <mailhol@kernel.org=
> wrote:
>
> Add unit tests for the new used-to-be-signed check as introduced in [1]:

Applied and pushed on sparse-dev repo. Can you please take a look if I
am doing it correctly on the sparse-dev?
Linus has one more debug print line, can you add it for me and submit
an incremental patch? It should be just a one liner. I will squash it
with your change. I can ping you on the other email as well.

I intend to use sparse-dev as the unstable sparse developer repo. It
will always be based on sparse repo but the commit in sparse-dev can
be rewinded. Patches will sit in the sparse-dev for about a week then
move into sparse repo. The sparse repo is a stable repo, it will not
rewind.

BTW, the recommended base to submit the sparse patches is the stable
sparse repo unless you depend on some bleeding edge feature only on
sparse-dev repo. Pull request please base on the sparse repo not the
unstable sparse-dev repo.

Thanks

Chris
