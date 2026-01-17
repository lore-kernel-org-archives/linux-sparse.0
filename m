Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25F13595B
	for <linux-sparse@vger.kernel.org>; Sat, 17 Jan 2026 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768667534; cv=none; b=fv3Y5vZg0vgCbdAObnX4YIWRaOa+ZqOSsf7T9hm79rXGorTVmadm7Bs2+6QbPR17WJQfHDPDvh23RWV4Iiee2CTCPN9jYj8M/2vYVVsieZ3yF7PC2L3D+3CL7Xw1ADcPT0KHqe9z+rwJcPdx/A+ouwXrazjQK/lkAStZ3yLAgWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768667534; c=relaxed/simple;
	bh=KEoghm+LX6RZzdhi7tZ+WjsY40kMMuHnOo6NaIYDsII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pwgD+qvdJ80rsOmG4AF5/wsPto9PkwaIcqVOYdK82p0vcsXhTaJ+2+EjfU2YBFwkcv/3c/BOMBdszF4T5rzJ7s7bGsoscCezs/gb7Ld9qCCP7kCKXozUSqIWpxkyUhzR1FCi2elco6DQZ+U7NkA/bkLZ9h5TCsemjdma5BVguVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TCUaMIdU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCUaMIdU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768667531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pAFuRWTzmavH68rx5Rra2sE03kcbJM25nrwdzoV6FUc=;
	b=TCUaMIdUIpJBHJgeSgDRJBRYmFWPp6rNDgLg/cJn8cpHbyIC0DbEtgJ2N6wgcd+DXga8QS
	2QDEdd08mwjjJFrgEAupNyexOoyCTI6AB5rKG242vg9WXSjE9PyIvECLcb3WDaFgmwa/X6
	tankpKBWutaqfjVzLUW0D5aqaOc/GZk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-rUYXhuMNPUqxxXAfmj0ixg-1; Sat,
 17 Jan 2026 11:32:08 -0500
X-MC-Unique: rUYXhuMNPUqxxXAfmj0ixg-1
X-Mimecast-MFC-AGG-ID: rUYXhuMNPUqxxXAfmj0ixg_1768667527
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 408391956058;
	Sat, 17 Jan 2026 16:32:07 +0000 (UTC)
Received: from fedora (unknown [10.44.32.14])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A0B1C1955F22;
	Sat, 17 Jan 2026 16:32:05 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 17 Jan 2026 17:32:06 +0100 (CET)
Date: Sat, 17 Jan 2026 17:32:03 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Chris Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <lucvoo@kernel.org>,
	Alexey Gladkov <legion@kernel.org>, linux-sparse@vger.kernel.org
Subject: Re: [PATCH] sparse/pre-process: introduce "dissect_mode" option to
 fix dissect/semind
Message-ID: <aWu5g1VkGe0ktRaW@redhat.com>
References: <aULJmGi8yib_XH0P@redhat.com>
 <CACePvbW2OybP7P-Vk+pa23SqA0+R0i8=20TiQMq99PvNAYJ8GA@mail.gmail.com>
 <aWuagcDh53AQxEmw@redhat.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aWuagcDh53AQxEmw@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LOCsR_o9Gr3dbCtiG7N1Lun9IWcp-qTXciuuHFZY2Gs_1768667527
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 01/17, Oleg Nesterov wrote:
>
> Agreed! This was my plan B ;)
>
> With this change
>
> 	-               if (!dissect_mode) {
> 	+               if (preprocess_only) {
>
> make check reports 2 failures
>
> 	-parsing/attr-cleanup.c:10:17: error: argument is not an identifier
> 	+parsing/attr-cleanup.c:10:27: error: argument is not an identifier
>
> 	-sizeof-void.c:20:14: warning: expression using sizeof(void)
> 	+sizeof-void.c:20:27: warning: expression using sizeof(void)
>
> but the new positions look more correct.
>
> However. I didn't dare to send this patch because other warnings from
> sizeof-void.c still blame the column 14, this looks inconsistent...
> But perhaps we don't really care?

On a 2nd thought...

Unlike other warnings, this one (sizeof-void.c:20:27) refers to the
inner "sizeof *ptr", so I think that this patch fixes the reported
position. So yes, I think we don't care even if the new column == 27
differs from other warnings.

What do you think?

Oleg.


> So. I am going to update the changelog and send the trivial V2 below.
>
> Will you agree?
>
> Oleg.
> ---
>
> diff --git a/pre-process.c b/pre-process.c
> index 3fb25082..a4bb6cb6 100644
> --- a/pre-process.c
> +++ b/pre-process.c
> @@ -294,9 +294,11 @@ static struct token *collect_arg(struct token *prev, int vararg, struct position
>  		} else if (match_op(next, ',') && !nesting && !vararg) {
>  			break;
>  		}
> -		next->pos.stream = pos->stream;
> -		next->pos.line = pos->line;
> -		next->pos.pos = pos->pos;
> +		if (preprocess_only) {
> +			next->pos.stream = pos->stream;
> +			next->pos.line = pos->line;
> +			next->pos.pos = pos->pos;
> +		}
>  		next->pos.newline = 0;
>  		p = &next->next;
>  	}
> diff --git a/validation/parsing/attr-cleanup.c b/validation/parsing/attr-cleanup.c
> index ac64649c..fa3cb1ca 100644
> --- a/validation/parsing/attr-cleanup.c
> +++ b/validation/parsing/attr-cleanup.c
> @@ -24,7 +24,7 @@ int test(int n)
>   * check-command: sparse -Wunknown-attribute $file
>   *
>   * check-error-start
> -parsing/attr-cleanup.c:10:17: error: argument is not an identifier
> +parsing/attr-cleanup.c:10:27: error: argument is not an identifier
>  parsing/attr-cleanup.c:11:39: error: an argument is expected for attribute 'cleanup'
>  parsing/attr-cleanup.c:12:40: error: an argument is expected for attribute 'cleanup'
>  parsing/attr-cleanup.c:13:43: error: Expected ) after attribute's argument'
> diff --git a/validation/sizeof-void.c b/validation/sizeof-void.c
> index 0fd917a2..6792ff02 100644
> --- a/validation/sizeof-void.c
> +++ b/validation/sizeof-void.c
> @@ -36,7 +36,7 @@ sizeof-void.c:16:14: warning: expression using sizeof(void)
>  sizeof-void.c:17:14: warning: expression using sizeof(void)
>  sizeof-void.c:18:14: warning: expression using sizeof(void)
>  sizeof-void.c:19:14: warning: expression using sizeof(void)
> -sizeof-void.c:20:14: warning: expression using sizeof(void)
> +sizeof-void.c:20:27: warning: expression using sizeof(void)
>  sizeof-void.c:21:14: warning: expression using sizeof(void)
>  sizeof-void.c:22:14: warning: expression using sizeof(void)
>  sizeof-void.c:23:14: warning: expression using sizeof(void)

