Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7340E8834
	for <linux-sparse@vger.kernel.org>; Wed, 24 Sep 2025 17:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758736039; cv=none; b=Wl+4N+vxhy6Ayf4nIgpBQJlfcTHM0HoD0scGZykm1w3tpjcn60LNC0T9XeG0wMHtEBKBUmt9Ca6f5FkugYvHAqtPrXfoXC6Vt4h/6R/Sebge4TfDiUthDuE24mSzwTFNyqZCkfQuDDYLTOnQZo4nPnP131AKPh4br30dFx6MYio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758736039; c=relaxed/simple;
	bh=Uank25nXgJXDItTds5ia+r7kAWIlXQI5gJOC5Gy0KBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJFK/VUnWbzW9Kh92nywjqjcNlvqYobfSjUOu2nQRo5OW10auB/zkrW8KPe70UtcEph5WYISpk0Q9JQmRUo+NqdlTVTEj8wRm4+qEQBSZvEy6HKVFfsLc/HMrZt9L3zrZiaykCoCqBvopm6eEgSwDKig8UZ4qao4VuBf6RWTcfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-ea5bcc26849so93281276.1
        for <linux-sparse@vger.kernel.org>; Wed, 24 Sep 2025 10:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758736036; x=1759340836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uank25nXgJXDItTds5ia+r7kAWIlXQI5gJOC5Gy0KBo=;
        b=V7HbLU5sOsSUMoUPqlOYg6eu8QmPR3/BHRVrLQavgxuAG+9NB75p2lCGSST8ZQr/dC
         co8b5+LKAHgEvMG25vKvYHUHTZXVGoCOAcdlX7APCmeeVfDkn7Ua7p0dcAttlYWpwoKp
         SZ45aJxq6qvpfDq41z18xQ7rl4WZJI9X2TSGGkuK5tViODeJrm3/ybXnEaH3H8CRcYMM
         ca7PGk798dpM5gKqZlcszQnQ1yT1LynBwElQuyaYjcFTKBhjp0M6rSMgAAHStv4sUgdP
         +bFSvPmktvaYxG1G/GnOk2cs/u1rw1ivVg3Q5y0zVl2nKRyhijVgdScVORlM7FQ/Wp7a
         ny0w==
X-Gm-Message-State: AOJu0YxDl9X2Bv0SdYqbrGzs6K1J364p25/vwtXnFyh3VCNzV8lkuEbM
	BVFgGCXhjuA+QSwKeMO1ShnLTTjabt3ab5XvAghiozYgopNq19d7nSXCAlWvmqSbXlD8FoTlPCZ
	Gl1hFWieg3Y+iV5fuMot3vLYaMdVjhhbVoo0gVfsxhg==
X-Gm-Gg: ASbGncuN6zblKf/bCkytP/0aYtU4gEG4rUOosnHJa1Qr5viTmalzp6Rs06d09ZZ3kQ9
	VzeGPJOj33giT3VgCVEZeQWmQ9i7CfBOgfz9qViRjBmHsDyX6z9MdlENK/EgXO9Uo4gctC9Y10Z
	uWJ0DEzrbh0HX0PzOvKMCsewUs5cMsGukvAHejpaDdODJFlYZjRvzRq5dYEUOq23iaT4Mbv5e7t
	M1l60Asx3KDtRLHfTBkH8c=
X-Google-Smtp-Source: AGHT+IGv0M+aMXlhNE4OYW6rGrakHRhIUHe0C4IqMOqXlDkqphbxDODteC1lkSIREtKFetujEMk/NkmF+uRwEAs7COM=
X-Received: by 2002:a05:6902:2b87:b0:eaf:5c0e:5155 with SMTP id
 3f1490d57ef6-eb37fd1458amr777944276.37.1758736036011; Wed, 24 Sep 2025
 10:47:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACePvbWQVBNQAAreW-Mzkp8ircGtV+K=gNk39HmUC0TNDOBCwQ@mail.gmail.com>
 <20250922155415.3289196-1-mailhol@kernel.org> <CACePvbXaHKH5Vp+j53pk6494pgDEABQpZ_gOo9_nmCZ4gjxUHw@mail.gmail.com>
 <78229b37-a816-4128-b0be-ca73d9c05da7@kernel.org>
In-Reply-To: <78229b37-a816-4128-b0be-ca73d9c05da7@kernel.org>
From: Chris Li <sparse@chrisli.org>
Date: Wed, 24 Sep 2025 10:47:05 -0700
X-Gm-Features: AS18NWBtm0UKb93qGTie62b8dMXXyzmTD4okcu2hV-Ve1naqye0tOveBcT7BN9g
Message-ID: <CACePvbXLAtCjgdq5r43NCjk7bNfU3EgJ4naFj5ZiFRFkW+iQqA@mail.gmail.com>
Subject: Re: [PATCH] vadidation: add used-to-be-signed unit tests
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-sparse@vger.kernel.org, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 2:28=E2=80=AFAM Vincent Mailhol <mailhol@kernel.org=
> wrote:
>
> On 24/09/2025 at 16:03, Chris Li wrote:
> > On Mon, Sep 22, 2025 at 8:54=E2=80=AFAM Vincent Mailhol <mailhol@kernel=
.org> wrote:
> >>
> >> Add unit tests for the new used-to-be-signed check as introduced in [1=
]:
> >
> > Applied and pushed on sparse-dev repo. Can you please take a look if I
> > am doing it correctly on the sparse-dev?
>
> I just checked out sparse-dev. I re-run the tests and everything looks fi=
ne!

Thanks for the confirmation.


>
> > Linus has one more debug print line, can you add it for me and submit
> > an incremental patch? It should be just a one liner. I will squash it
> > with your change. I can ping you on the other email as well.
>
> I replied in the other thread. That one line is already in the final patc=
h ;)

Ack.

>
> > I intend to use sparse-dev as the unstable sparse developer repo. It
> > will always be based on sparse repo but the commit in sparse-dev can
> > be rewinded. Patches will sit in the sparse-dev for about a week then
> > move into sparse repo. The sparse repo is a stable repo, it will not
> > rewind.
> >
> > BTW, the recommended base to submit the sparse patches is the stable
> > sparse repo unless you depend on some bleeding edge feature only on
> > sparse-dev repo. Pull request please base on the sparse repo not the
> > unstable sparse-dev repo.
> Ack. At the moment, I am not planning to do more sparse development, this=
 patch
> will likely be a one shot. But I will keep this in mind if I either decid=
e to do
> another contribution.

That is more of a note for the general sparse patch submission.
Alignment for how to use the two sparse repo. I will send a separate
email to the sparse mailing list.

Thanks for your first two patches after I am back as the maintainer.

Chris
