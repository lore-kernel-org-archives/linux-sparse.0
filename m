Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625C622FDFF
	for <linux-sparse@vger.kernel.org>; Mon, 19 Jan 2026 12:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768825986; cv=none; b=qXoZWeYkAmPXdMpkX5bXSSUXFRwkKaBISfiveKjMu/KWy4tP+FRBsxLGvxUbzBvCwIZbmA3AvsntGWAYNWUr0mCULv0dJNJLje8jjPe1/Kos6wd5lwpC0mbcUGbVZ7W+XifsCqlF1fUbCMpVYOKBZZ03VPHdhwe6m7WnIBBvRs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768825986; c=relaxed/simple;
	bh=i3hsGS0pUj7EGcq+Tc3/dOUXLo7FKE1blYiehdBzORI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Hb1cfIQ6lZFEwso4rbFZ+cY6VsItdRQKeFy7Y/vmXtWRxc/7POIkomhFcBJ5oWzk0zTwPxn6GkpC3I54hoY/Q0lIWdkkmCeYCW8TS8XH94GfWMwy1VmFCUjWK3F8wT6A4Kqr9+pEKYnH2G+O3ff1i3e2vMOFVeMdYBR2mQQwkE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZhHp3xt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZhHp3xt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768825984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Sh/WGXdrqYgx/1SqZs5wNEd0zGF+41SfbuHpfPFZi0=;
	b=IZhHp3xtQhML3RWKGxVhygIiWnF3+Q6seNHUNQjGGN+xJAZolhZnsOuzDYLGihbxBPBRsH
	G0eJqfiO6xvzuNt3ycf71Neu9tcT29S+KvTUOvbkPLvdbS68iuwSwC2tadW4+kkrwKOHIl
	Vjsmanum850Bu4WiBunidZt3dNeToAc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-V1Es3rz6PPG-zOODFADzkw-1; Mon,
 19 Jan 2026 07:33:01 -0500
X-MC-Unique: V1Es3rz6PPG-zOODFADzkw-1
X-Mimecast-MFC-AGG-ID: V1Es3rz6PPG-zOODFADzkw_1768825980
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3899B1956058;
	Mon, 19 Jan 2026 12:33:00 +0000 (UTC)
Received: from fedora (unknown [10.44.33.237])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 65C1430001A7;
	Mon, 19 Jan 2026 12:32:58 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 19 Jan 2026 13:32:59 +0100 (CET)
Date: Mon, 19 Jan 2026 13:32:56 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Chris Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <lucvoo@kernel.org>,
	Alexey Gladkov <legion@kernel.org>, linux-sparse@vger.kernel.org
Subject: Re: [PATCH] sparse/pre-process: introduce "dissect_mode" option to
 fix dissect/semind
Message-ID: <aW4keHjmqTS_S9ie@redhat.com>
References: <aULJmGi8yib_XH0P@redhat.com>
 <CACePvbW2OybP7P-Vk+pa23SqA0+R0i8=20TiQMq99PvNAYJ8GA@mail.gmail.com>
 <aWuagcDh53AQxEmw@redhat.com>
 <aWu5g1VkGe0ktRaW@redhat.com>
 <CACePvbXb+EJ9tdq=E8pw3uC-fjYp4CgQ27GqLwEgirWJiMVU6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CACePvbXb+EJ9tdq=E8pw3uC-fjYp4CgQ27GqLwEgirWJiMVU6g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2RxLObLCwTiIxr_rHDtmPPrzVZiNW5N8JvsqrP6Vw8Q_1768825980
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 01/18, Chris Li wrote:
>
> On Sat, Jan 17, 2026 at 8:32 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On a 2nd thought...
> >
> > Unlike other warnings, this one (sizeof-void.c:20:27) refers to the
> > inner "sizeof *ptr", so I think that this patch fixes the reported
> > position. So yes, I think we don't care even if the new column == 27
> > differs from other warnings.
> >
> > What do you think?
>
> I would just update the checker to have the new expected value
> matching what new pos so validation can pass without errors.

Yes, this is what I did. See

	[PATCH] sparse/pre-process: don't update next->pos in collect_arg()
	https://lore.kernel.org/all/aWz0V_zQ47afKFJy@redhat.com/

I was confused and tried to confuse you... let me explain. With this patch
./sparse -Wpointer-arith validation/sizeof-void.c outputs

	validation/sizeof-void.c:16:14: warning: expression using sizeof(void)
	validation/sizeof-void.c:17:14: warning: expression using sizeof(void)
	validation/sizeof-void.c:18:14: warning: expression using sizeof(void)
	validation/sizeof-void.c:19:14: warning: expression using sizeof(void)
	validation/sizeof-void.c:20:27: warning: expression using sizeof(void) // changed
	validation/sizeof-void.c:21:14: warning: expression using sizeof(void)
	validation/sizeof-void.c:22:14: warning: expression using sizeof(void)
	validation/sizeof-void.c:23:14: warning: expression using sizeof(void)

and somehow I wrongly came to conlusion that my patch is incomplete or
inconsistent because it only corrects the warning's position for the
line 20.

Now that I actually looked at validation/sizeof-void.c, I see that the
code at line 20

	s += is_constexpr(sizeof *ptr);

differs in that it is the inner "sizeof *ptr" which triggers the warning,
so I think the patch is fine.

Thank you,

Oleg.

