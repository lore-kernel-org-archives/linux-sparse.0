Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17BE78F3A
	for <linux-sparse@vger.kernel.org>; Sat, 17 Jan 2026 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768659596; cv=none; b=ru6eggSYobseZSYnp5DIn3bh98iXj1CP0T4X9PAmM4D2cJfnlXH6j7DPLR20MrGITCnKokRvzSa839iE9BQsp0IN97SAkPlrLQUng7qswcQsBEuyhMlK3Z/oLI9Ex+1O1lehJoTejCjTEX523YpwbVWTuhEKQfRR1+4w4uEYzT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768659596; c=relaxed/simple;
	bh=VewOdHbPLWy3Ns1CbAZ0E6E+OKaCGZHoxRMhkmONj5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jb+JNPvdd5xVbgoqtQkXqVTgrvZcbTc9bVzV9hgOEZhpMkB7xzf7ZkpEsmSr46HXS5o2vV4QWMOXlHDYQ+0LJVVxqCE0acBG4anLCR+euAHFTMNl3pkQ5jm3Rj4yh/UqnMexmPnlmaujEZxEQr8vvmLTaGq1KHNwO4v8DNBQbx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R3QmtF+D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3QmtF+D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768659593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DKY58hbLKxnQ91+1fJO71s/ymryzbpI2KSUCge7rru8=;
	b=R3QmtF+DB5b+tEczQznTw5Z2sK5Gq3Y90vIh1o2lYcujebIfTU13UyEADsetKIJbdFcczy
	ecTRvgJoq9iDRn+FZ6GkVvLmYyYDokcYFHWz44yJGS/9wywtyz6I6BbD2+SoB9Phh4Xt+7
	uaw1fpRg1MjjGvf7fYmeiB061u1b2Bc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-q67tSDt7NTevFKAX2MjfSg-1; Sat,
 17 Jan 2026 09:19:50 -0500
X-MC-Unique: q67tSDt7NTevFKAX2MjfSg-1
X-Mimecast-MFC-AGG-ID: q67tSDt7NTevFKAX2MjfSg_1768659589
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13266180044D;
	Sat, 17 Jan 2026 14:19:49 +0000 (UTC)
Received: from fedora (unknown [10.44.32.14])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3C2D219560A7;
	Sat, 17 Jan 2026 14:19:46 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 17 Jan 2026 15:19:48 +0100 (CET)
Date: Sat, 17 Jan 2026 15:19:45 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Chris Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <lucvoo@kernel.org>,
	Alexey Gladkov <legion@kernel.org>, linux-sparse@vger.kernel.org
Subject: Re: [PATCH] sparse/pre-process: introduce "dissect_mode" option to
 fix dissect/semind
Message-ID: <aWuagcDh53AQxEmw@redhat.com>
References: <aULJmGi8yib_XH0P@redhat.com>
 <CACePvbW2OybP7P-Vk+pa23SqA0+R0i8=20TiQMq99PvNAYJ8GA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CACePvbW2OybP7P-Vk+pa23SqA0+R0i8=20TiQMq99PvNAYJ8GA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kiicg9IRseZuz88OMXEzsKlwwCINNvx3YDz6ng7bMCM_1768659589
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Chris,

On 01/16, Chris Li wrote:
>
> On Wed, Dec 17, 2025 at 7:26 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > I don't quite understand why does expand() -> collect_arg() path
> > update ->pos for each token in the input *list, but this breaks
> > dissect and thus semind.
>
> That is a good question, I don't understand why it did that either. I
> did some digging, inside macro argument list expansion, the "#include
> " is not allowed. It is not possible to switch streams here. The
> "pos.pos" is for human consumption anyway, it has no effect on the IR
> generation. The only visible effect as far as I can tell is related to
> the preprocessor "-E" in lib.c:
>
>         if (preprocess_only) {
>                 while (!eof_token(token)) {
>                         int prec = 1;
>                         struct token *next = token->next;
>                         const char *separator = "";
>                         if (next->pos.whitespace)
>                                 separator = " ";
>                         if (next->pos.newline) {
>                                 separator = "\n\t\t\t\t\t";
>                                 prec = next->pos.pos; <--- use pos as
> indentation level.
>                                 if (prec > 4)
>                                         prec = 4;
>                         }
>                         printf("%s%.*s", show_token(token), prec, separator);
>                         token = next;
>
> The "-E" output has some indentation enhancement to turn space into
> tab level indentation. This "pos" assignment tries to align the
> indentation context of the input arguments to the same level of the
> expanding macro name.

Yes, exactly! Initially I tried to simply remove these next->pos.* updates
in collect_arg(), but this causes a lot of failures in validation/preprocessor
(due to extra indentations) and I failed to find a simple fix for the
"if (preprocess_only)" code above. Plus I wasn't comfortable because
I don't understand the intent...

> >  void dissect(struct reporter *rep, struct string_list *filelist)
> >  {
> > +       dissect_mode = 1;
>
> I don't think we need dissect_mode. I am leaning towards enabling it
> all the time, maybe except for the preprocessor only mode.

...

> > +               if (!dissect_mode) {
> > +                       next->pos.stream = pos->stream;
> > +                       next->pos.line = pos->line;
> > +                       next->pos.pos = pos->pos;
> > +               }
>
> Maybe change it to "if (preprocess_only)", and fix all the validation
> error output of the checker. What do you say?

Agreed! This was my plan B ;)

With this change

	-               if (!dissect_mode) {
	+               if (preprocess_only) {

make check reports 2 failures

	-parsing/attr-cleanup.c:10:17: error: argument is not an identifier
	+parsing/attr-cleanup.c:10:27: error: argument is not an identifier

	-sizeof-void.c:20:14: warning: expression using sizeof(void)
	+sizeof-void.c:20:27: warning: expression using sizeof(void)

but the new positions look more correct.

However. I didn't dare to send this patch because other warnings from
sizeof-void.c still blame the column 14, this looks inconsistent...
But perhaps we don't really care?

So. I am going to update the changelog and send the trivial V2 below.

Will you agree?

Oleg.
---

diff --git a/pre-process.c b/pre-process.c
index 3fb25082..a4bb6cb6 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -294,9 +294,11 @@ static struct token *collect_arg(struct token *prev, int vararg, struct position
 		} else if (match_op(next, ',') && !nesting && !vararg) {
 			break;
 		}
-		next->pos.stream = pos->stream;
-		next->pos.line = pos->line;
-		next->pos.pos = pos->pos;
+		if (preprocess_only) {
+			next->pos.stream = pos->stream;
+			next->pos.line = pos->line;
+			next->pos.pos = pos->pos;
+		}
 		next->pos.newline = 0;
 		p = &next->next;
 	}
diff --git a/validation/parsing/attr-cleanup.c b/validation/parsing/attr-cleanup.c
index ac64649c..fa3cb1ca 100644
--- a/validation/parsing/attr-cleanup.c
+++ b/validation/parsing/attr-cleanup.c
@@ -24,7 +24,7 @@ int test(int n)
  * check-command: sparse -Wunknown-attribute $file
  *
  * check-error-start
-parsing/attr-cleanup.c:10:17: error: argument is not an identifier
+parsing/attr-cleanup.c:10:27: error: argument is not an identifier
 parsing/attr-cleanup.c:11:39: error: an argument is expected for attribute 'cleanup'
 parsing/attr-cleanup.c:12:40: error: an argument is expected for attribute 'cleanup'
 parsing/attr-cleanup.c:13:43: error: Expected ) after attribute's argument'
diff --git a/validation/sizeof-void.c b/validation/sizeof-void.c
index 0fd917a2..6792ff02 100644
--- a/validation/sizeof-void.c
+++ b/validation/sizeof-void.c
@@ -36,7 +36,7 @@ sizeof-void.c:16:14: warning: expression using sizeof(void)
 sizeof-void.c:17:14: warning: expression using sizeof(void)
 sizeof-void.c:18:14: warning: expression using sizeof(void)
 sizeof-void.c:19:14: warning: expression using sizeof(void)
-sizeof-void.c:20:14: warning: expression using sizeof(void)
+sizeof-void.c:20:27: warning: expression using sizeof(void)
 sizeof-void.c:21:14: warning: expression using sizeof(void)
 sizeof-void.c:22:14: warning: expression using sizeof(void)
 sizeof-void.c:23:14: warning: expression using sizeof(void)

