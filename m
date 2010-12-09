From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH] use ARRAY_SIZE() when possible
Date: Thu, 9 Dec 2010 13:36:02 +0100
Message-ID: <20101209123602.GB5470@opentech.at>
References: <1291894020-3388-1-git-send-email-namhyung@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:52368 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755941Ab0LIMrI (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 9 Dec 2010 07:47:08 -0500
Content-Disposition: inline
In-Reply-To: <1291894020-3388-1-git-send-email-namhyung@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Namhyung Kim <namhyung@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

On Thu, 09 Dec 2010, Namhyung Kim wrote:

> Convert (sizeof arr / sizeof arr[0]) to ARRAY_SIZE(arr).
>
would that not be a cadidate for coccinelle/spatch rather than a potentially
error prone and repetitive manual patch?
array.cocci from the current 0.4.2 coccinelle distribution below should du
the job. 
Might make sense to add a coccinelle directory in sparse to handle such cases ?

hofrat
 
// Use the macro ARRAY_SIZE when possible
//
// Confidence: High
// Copyright: (C) Gilles Muller, Julia Lawall, EMN, INRIA, DIKU.  GPLv2.
// URL: http://coccinelle.lip6.fr/rules/array.html
// Options: -I ... -all_includes can give more complete results
virtual org
virtual patch

@i@
@@

#include <linux/kernel.h>

/////////////////////////////////////
/////////////////////////////////////
@depends on i && patch && !org@
type T;
T[] E;
@@

- (sizeof(E)/sizeof(*E))
+ ARRAY_SIZE(E)

@depends on i && patch && !org@
type T;
T[] E;
@@

- (sizeof(E)/sizeof(E[...]))
+ ARRAY_SIZE(E)

@depends on i && patch && !org@
type T;
T[] E;
@@

- (sizeof(E)/sizeof(T))
+ ARRAY_SIZE(E)

@n_patch depends on patch && !org@
identifier AS,E;
@@

- #define AS(E) ARRAY_SIZE(E)

@ depends on patch && !org@
expression E;
identifier n_patch.AS;
@@

- AS(E)
+ ARRAY_SIZE(E)


/////////////////////////////////////
/////////////////////////////////////
@arr_ptr depends on i && !patch && org@
type T;
T[] E;
position p;
@@

 (sizeof(E@p)/sizeof(*E))

@arr_tab depends on i && !patch && org@
type T;
T[] E;
position p;
@@

 (sizeof(E@p)/sizeof(E[...]))

@arr_typ depends on i && !patch && org@
type T;
T[] E;
position p;
@@

 (sizeof(E@p)/sizeof(T))

@n_org depends on !patch && org@
identifier AS,E;
@@

#define AS(E) ARRAY_SIZE(E)

@arr_def depends on !patch && org@
expression E;
identifier n_org.AS;
position p;
@@

AS@p(E)

@script:python@
p << arr_ptr.p;
e << arr_ptr.E;
@@
cocci.print_main(e,p)

@script:python@
p << arr_tab.p;
e << arr_tab.E;
@@
cocci.print_main(e,p)

@script:python@
p << arr_typ.p;
e << arr_typ.E;
@@
cocci.print_main(e,p)

@script:python@
p << arr_def.p;
e << arr_def.E;
@@
cocci.print_main(e,p)
