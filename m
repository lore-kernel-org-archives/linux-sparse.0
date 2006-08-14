From: Josh Triplett <josht@us.ibm.com>
Subject: Re: [PATCH] Recognize and ignore __alias__ and __visibility__
Date: Mon, 14 Aug 2006 08:52:25 -0700
Message-ID: <1155570745.5410.8.camel@josh-work.beaverton.ibm.com>
References: <20060813055158.28706.93407.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:23487 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751440AbWHNPw1
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 14 Aug 2006 11:52:27 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k7EFqPxH002848
	for <linux-sparse@vger.kernel.org>; Mon, 14 Aug 2006 11:52:25 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k7EFqPo0031702
	for <linux-sparse@vger.kernel.org>; Mon, 14 Aug 2006 09:52:25 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k7EFqORi012553
	for <linux-sparse@vger.kernel.org>; Mon, 14 Aug 2006 09:52:24 -0600
In-Reply-To: <20060813055158.28706.93407.stgit@dv.roinet.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org

On Sun, 2006-08-13 at 01:51 -0400, Pavel Roskin wrote:
> diff --git a/parse.c b/parse.c
> index c536ec2..1c9aab8 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -530,6 +530,8 @@ static const char * handle_attribute(str
>  		return NULL;
>  	if (attribute == &alias_ident)
>  		return NULL;
> +	if (attribute == &__alias___ident)
> +		return NULL;
>  	if (attribute == &pure_ident ||
>  	    attribute == &__pure___ident)
>  		return NULL;
> @@ -539,6 +541,8 @@ static const char * handle_attribute(str
>  		return NULL;
>  	if (attribute == &visibility_ident)
>  		return NULL;
> +	if (attribute == &__visibility___ident)
> +		return NULL;
>  	if (attribute == &deprecated_ident ||
>  	    attribute == &__deprecated___ident)
>  		return NULL;

Stylistically, it looks like all of the existing ignored keywords in
this function use a single combined if condition for the underscored and
non-underscored versions of a given keyword, rather than two separate if
conditions.  For consistency, what about something like the following
instead:

diff --git a/ident-list.h b/ident-list.h
index 95bb96a..ecdce6d 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -56,8 +56,8 @@ IDENT(__const); IDENT(__const__); IDENT(
 IDENT(__noreturn__); IDENT(regparm); IDENT(weak); IDENT(__weak__);
 IDENT(__no_instrument_function__); IDENT(no_instrument_function);
 IDENT(__sentinel__); IDENT(sentinel);
-IDENT(alias); IDENT(pure); IDENT(always_inline);
-IDENT(syscall_linkage); IDENT(visibility);
+IDENT(alias); IDENT(__alias__); IDENT(pure); IDENT(always_inline);
+IDENT(syscall_linkage); IDENT(visibility); IDENT(__visibility__);
 IDENT(bitwise); IDENT(__bitwise__);
 IDENT(model); IDENT(__model__);
 IDENT(__format_arg__);
diff --git a/parse.c b/parse.c
index c536ec2..6857541 100644
--- a/parse.c
+++ b/parse.c
@@ -528,7 +528,8 @@ static const char * handle_attribute(str
 	if (attribute == &weak_ident ||
 	    attribute == &__weak___ident)
 		return NULL;
-	if (attribute == &alias_ident)
+	if (attribute == &alias_ident ||
+	    attribute == &__alias___ident)
 		return NULL;
 	if (attribute == &pure_ident ||
 	    attribute == &__pure___ident)
@@ -537,7 +538,8 @@ static const char * handle_attribute(str
 		return NULL;
 	if (attribute == &syscall_linkage_ident)
 		return NULL;
-	if (attribute == &visibility_ident)
+	if (attribute == &visibility_ident ||
+	    attribute == &__visibility___ident)
 		return NULL;
 	if (attribute == &deprecated_ident ||
 	    attribute == &__deprecated___ident)

- Josh Triplett
