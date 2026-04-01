Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11EF33D4FD
	for <linux-sparse@vger.kernel.org>; Wed,  1 Apr 2026 19:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775072963; cv=none; b=gEQKBeGQao2YoT604a6MWaMT+k/PkHw4GRGI4p92AtYj7mz/tekzfXQQ1x2fxfjDHvXFeBcHyzoTy/loOy4k+3XVOwCkT1dTR04rdygfp5OdkldetjrOI6pExPn7T3VG5Pi2TvIQRi3iW7VfXizIwIwZBHYmyC1nQaWtss5j4a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775072963; c=relaxed/simple;
	bh=KNqlve+VixiVnaFO+OjgyjSidAo9d4seITfI+vBoju4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8yBpyMMyPJJ94UzNaSgbJAZuwEDW/qfS8tJR2G0YlfNMlManBsS3uuA5e1YV6Trr7SYOqVPlrup7ajdGmqZ0KbueBJihmOA7Dg1pNzS2gNwNR20Pl8TJ9Y62ztZ6HSL6+PMRxBYueZQGIcZV4wIumYlJqDXaTh7BbBleyvWebE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=I+nSvwO6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="I+nSvwO6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YH0Uf9Nku+mrVUkz+GlI3IZTV4ZEYxn0XzZdFH4A13M=; b=I+nSvwO6YnSCAoWoD9eLeepbgG
	d2I6nrD4O5rjnPuSsEsUcSsoTXGWDIJ209vwxIVBJuuaLdpbZssxfl23/afiYR76rtdTjvQf9JdDb
	1H4vnCfj7p9VOm2DcQlAFRtZYwnJNo9JolDQ3w9MxLUxi7rsrcSKRztnvaCYVQRD1zDFOPlqMww3f
	x9MAnPFjdWt9277w49WJeYPXUrmjhs5qoNnysX8uCsGWNGvXj3JVZRRdpPorZ8ZUlOy3cKxW7SWoU
	uJH5qzymlDH3RonhX6H+MDy9d8zX80e3y2kQrLXiJIen23n3UFgA/9hjQdYeGBgs9iEKKb6Pa+DjP
	YFmFZtBA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w81cR-000000049B8-3UoS;
	Wed, 01 Apr 2026 19:52:51 +0000
Date: Wed, 1 Apr 2026 20:52:51 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: chriscli@google.com, linux-sparse@vger.kernel.org,
	dan.carpenter@linaro.org, ben.dooks@codethink.co.uk,
	rf@opensource.cirrus.com, Eric Zhang <zxh@xh-zhang.com>
Subject: Re: [RFC PATCH] pre-process: add __VA_OPT__ support
Message-ID: <20260401195251.GA974193@ZenIV>
References: <20260225072731.GA3093958@ZenIV>
 <20260225081413.2480484-1-zxh@xh-zhang.com>
 <20260225221851.GE1762976@ZenIV>
 <20260226072945.GA4104757@ZenIV>
 <20260316065622.GA607739@ZenIV>
 <20260331080631.GA1328137@ZenIV>
 <20260401103919.GA2063236@ZenIV>
 <CAHk-=whC+8jX=t9NsF3uG_=BoLDNG7q0+FCm4ZrQDFdirWaasA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whC+8jX=t9NsF3uG_=BoLDNG7q0+FCm4ZrQDFdirWaasA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Apr 01, 2026 at 09:18:34AM -0700, Linus Torvalds wrote:

> I suspect this part of the patch is more likely to actually be
> something that somebody may actually want some day:
> 
>   +// We ought to add __builtin_strcmp() support to constant expressions;
>   +// what's more, "foo"[0] should also be recognized as one...
>   +// Sloppy length check for now...
> 
> because yeah, we've actually depended on the compiler just figuring
> some of those kinds of build-time optimizations out before to remove
> dead code etc.

Something like delta below ought to take care of __builtin_strcmp(); figuring
out the things like "ab"[1] being equal to 'b' is something I'd rather
leave for later - at the very least after I resurrect and repost the
busy-wait in shrink_dcache_parent() patchset.  I've really spent way
too much of the last couple of months on digging in sparse ;-/

As for the whitespace handling in preprocessor, I suspect that it'll
end up with several bug reports for gcc and a DR for ISO C folks re
clarifying that part of 6.10; not until summer, probably...

diff --git a/builtin.c b/builtin.c
index a704c5e8..21b41045 100644
--- a/builtin.c
+++ b/builtin.c
@@ -631,6 +631,49 @@ static struct symbol_op strlen_op = {
 	.expand = expand_strlen,
 };
 
+static int evaluate_strcmp(struct expression *expr)
+{
+	struct expression *arg;
+	bool non_const = false;
+
+	FOR_EACH_PTR(expr->args, arg) {
+		if (arg && arg->type == EXPR_SYMBOL)
+			arg = arg->symbol->initializer;
+		if (!arg || arg->type != EXPR_STRING || !arg->string->length)
+			non_const = true;
+	} END_FOR_EACH_PTR(arg);
+	if (!non_const)
+		expr->flags |= CEF_ICE;
+	return 1;
+}
+
+static int expand_strcmp(struct expression *expr, int cost)
+{
+	struct expression *arg;
+	const char *v[2];
+	int n = 0;
+
+	FOR_EACH_PTR(expr->args, arg) {
+		if (!arg)
+			return UNSAFE;
+		if (arg->type == EXPR_SYMBOL)
+			arg = arg->symbol->initializer;
+		if (!arg || arg->type != EXPR_STRING || !arg->string->length)
+			return UNSAFE;
+		v[n++] = arg->string->data;
+	} END_FOR_EACH_PTR(arg);
+	expr->flags |= CEF_SET_ICE;
+	expr->type = EXPR_VALUE;
+	expr->value = strcmp(v[0], v[1]);
+	expr->taint = 0;
+	return 0;
+}
+
+static struct symbol_op strcmp_op = {
+	.evaluate = evaluate_strcmp,
+	.expand = expand_strcmp,
+};
+
 /*
  * Builtin functions
  */
@@ -806,7 +849,7 @@ static const struct builtin_fn builtins_common[] = {
 	{ "__builtin_strcasestr", &string_ctype, 0, { &const_string_ctype, &const_string_ctype }},
 	{ "__builtin_strcat", &string_ctype, 0, { &string_ctype, &const_string_ctype }},
 	{ "__builtin_strchr", &string_ctype, 0, { &const_string_ctype, &int_ctype }},
-	{ "__builtin_strcmp", &int_ctype, 0, { &const_string_ctype, &const_string_ctype }},
+	{ "__builtin_strcmp", &int_ctype, 0, { &const_string_ctype, &const_string_ctype }, .op = &strcmp_op},
 	{ "__builtin_strcpy", &string_ctype, 0, { &string_ctype, &const_string_ctype }},
 	{ "__builtin_strcspn", size_t_ctype, 0, { &const_string_ctype, &const_string_ctype }},
 	{ "__builtin_strdup", &string_ctype, 0, { &const_string_ctype }},
diff --git a/validation/preprocessor/whitespace.c b/validation/preprocessor/whitespace.c
index 27bbea14..4396035b 100644
--- a/validation/preprocessor/whitespace.c
+++ b/validation/preprocessor/whitespace.c
@@ -1,23 +1,9 @@
 #define S(X) #X
 
-#if notyet
 #define EXPECT(X,Y) _Static_assert(__builtin_strcmp(S(X),Y) == 0, \
 				 #X " => " S(X) ", " Y "expected");
 #define Y(M) EXPECT(M(,]),"[ ]")
 #define N(M) EXPECT(M(,]),"[]")
-#else
-
-// We ought to add __builtin_strcmp() support to constant expressions;
-// what's more, "foo"[0] should also be recognized as one...
-// Sloppy length check for now...
-
-#define __Y(X) _Static_assert(__builtin_strlen(S(X)) == 3, \
-				#X " => " S(X) ", [ ] expected");
-#define Y(M) __Y(M(,]))
-#define __N(X) _Static_assert(__builtin_strlen(S(X)) == 2, \
-				#X " => " S(X) ", [] expected");
-#define N(M) __N(M(,]))
-#endif
 
 #define T1(X,R) []	// T
 #define A1(X,R) [R	// A
