Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32EEC5519F
	for <linux-sparse@archiver.kernel.org>; Wed, 18 Nov 2020 19:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 431882222C
	for <linux-sparse@archiver.kernel.org>; Wed, 18 Nov 2020 19:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFrT9MWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgKRTRl (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 18 Nov 2020 14:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgKRTRk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 18 Nov 2020 14:17:40 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7640FC0613D4
        for <linux-sparse@vger.kernel.org>; Wed, 18 Nov 2020 11:17:40 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id dk16so4299716ejb.12
        for <linux-sparse@vger.kernel.org>; Wed, 18 Nov 2020 11:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NafGFqtkdTOR2cWJcMrodyEfJ5V2wo3P07jWWEhn53o=;
        b=pFrT9MWsIQvZU/acpRDzzFI5qAOqvjD0KbZiMHlBc1oYk9FGTkboAb7WNOIF1d+SIH
         Eb4kJzqJSp+VbsgyCG3W52ajAxSMyJ0dwAnxYS0CyX24kSTPvxwUW2WCvVrMXU5e/ccz
         WTSzOjabYjCxIhL39DzuPKQ4G9zydofwYD7ZALKNqKOmK6YrAbrR49MQUQrLu38pz2x0
         HnEFVPBGHwrKjcXZJE013Cb0qhAEhyF3mtnjC6MowqmmYUon1M4zZOds7YBUkUT1ASJb
         BqzZK6I6zJz5zRfVLi5/raL9+vlUIGDzFG+abuFGHXg8VmGHCfiRTmiL9uTfmTaMXyaP
         Y+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NafGFqtkdTOR2cWJcMrodyEfJ5V2wo3P07jWWEhn53o=;
        b=p4Nss12MKp5KsjC2eXXKaa5txWct5G3A2IbZYDGLojw3pcC79dl8Sx9vGh/AFKwQwO
         sSKCieOxSYhkrSGjCEKq9RyEjZgK/5aqXFCsMwUfRfNigXDG/L3BZlIdGxCzXJr02007
         NsR4LdH+qv9MhdkC/bAQ02yE5fYv0Eo3o8bQ9/Rg451eX8+7VB4RQwihMB3NNdMGSMQW
         mNx9brnABmvHc21gec611xwDDb+QtQPY+YEp7/D5TAO0wnQCcBkYMtW5KYFjtcScGnNx
         K3MS9fyGxAGCqsdc0ZfwnsiKwejgiVGKMdRttKDt4gBYyilWD0G7upgm5UML0+HMmK7j
         nAyQ==
X-Gm-Message-State: AOAM5322XKACg3BRGVgTSwVrbiyw6TXT3Mp6LTt5nLx2LBAT3fEjwCmZ
        cc6WgSNHRyNp8wDCJ3kNpJj20T8xafw=
X-Google-Smtp-Source: ABdhPJwQDSc43W1WRlYeI/+SOO8HFvfTobIGkE4wqMB3D1weopyVKPDO71DPHUvwLc5wq6TId+MwRQ==
X-Received: by 2002:a17:906:37d2:: with SMTP id o18mr26132370ejc.379.1605727059217;
        Wed, 18 Nov 2020 11:17:39 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:491a:3e51:301b:6e24])
        by smtp.gmail.com with ESMTPSA id i4sm2307273edu.78.2020.11.18.11.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 11:17:38 -0800 (PST)
Date:   Wed, 18 Nov 2020 20:17:37 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] casts should drop qualifiers
Message-ID: <20201118191737.oq2e2t5h2wo3us3c@ltop.local>
References: <CAHk-=wivBmCoux_bVz_tZ12byZS=oZ7+F2Og8OjJGM5aiM-KQQ@mail.gmail.com>
 <20201117212829.99552-1-luc.vanoostenryck@gmail.com>
 <CAHk-=wgtL1LPYev5cwhZqd=7RyaGrzx3mS-ydVZAQuYrf0XNuQ@mail.gmail.com>
 <CAHk-=wi-XUPMduO16mvNeou58O-LrxnSk33WBg+vbbqCpzHgOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi-XUPMduO16mvNeou58O-LrxnSk33WBg+vbbqCpzHgOw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, Nov 18, 2020 at 10:31:43AM -0800, Linus Torvalds wrote:
> On Tue, Nov 17, 2020 at 3:22 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Would doing the same unqualify_type() in degenerate() be sufficient?
> 
> Actually, that's a stupid suggestion. Forget I ever mentioned it.
> 
> I should have reacted to Martin Ucker pointing out
> 
> > > lvalue conversion drops qualifers in C.  In GCC, this is not
> > > implemented correctly as it is unobvervable in standard C
> > > (but it using typeof).
> 
> with the notable point that it is unobservable outside of "typeof".
> 
> I'm not actually entirely sure that is true: if you don't drop
> qualifiers, it's potentially observable in code generation, in that a
> "volatile" that didn't get dropped might perhaps cause unnecessary

Yes, I had already added some testcases with volatile because the
the rules for const & volatile are different.

> memory ops. But from a kernel variable type standpoint where we want
> to just drop qualifiers on variables using "typeof()", maybe the
> simplest solution would be just special-casing typeof itself, using
> something (entirely untested and probably complete garbage) like this:

I don't think it's a good idea. The focus now is all about dropping
the qualifiers but in code like:
	const int x;
	typeof(c) y;
don't we want 'y' to also have the type 'const int'?

For the moment I'm testing the patch here under. It fixes the
qualifier dropping for comma expressions, and same for statement
expressions. It also, I think, fixes evaluate_postop() which
has the inverse error of dropping qualifiers but shouldn't.

I think that all the other cases are covered (but the code is fragile
because most qualifier dropping are done implicitly via classify_type()
which strip everything).


diff --git a/evaluate.c b/evaluate.c
index fd84205c7f2c..8599fcee6875 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1028,7 +1028,7 @@ static struct symbol *evaluate_binop(struct expression *expr)
 
 static struct symbol *evaluate_comma(struct expression *expr)
 {
-	expr->ctype = degenerate(expr->right);
+	expr->ctype = unqualify_type(degenerate(expr->right));
 	if (expr->ctype == &null_ctype)
 		expr->ctype = &ptr_ctype;
 	expr->flags &= expr->left->flags & expr->right->flags;
@@ -1935,8 +1935,7 @@ static struct symbol *evaluate_postop(struct expression *expr)
 	if (multiply) {
 		evaluate_assign_to(op, op->ctype);
 		expr->op_value = multiply;
-		expr->ctype = ctype;
-		return ctype;
+		return expr->ctype = op->ctype;
 	}
 
 	expression_error(expr, "bad argument type for ++/--");
@@ -3950,7 +3949,7 @@ struct symbol *evaluate_statement(struct statement *stmt)
 			return NULL;
 		if (stmt->expression->ctype == &null_ctype)
 			stmt->expression = cast_to(stmt->expression, &ptr_ctype);
-		return degenerate(stmt->expression);
+		return unqualify_type(degenerate(stmt->expression));
 
 	case STMT_COMPOUND: {
 		struct statement *s;


-- Luc
