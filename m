From: Neil Booth <neil@daikokuya.co.uk>
Subject: Array declarators not well diagnosed
Date: Wed, 2 May 2007 22:59:13 +0900
Message-ID: <20070502135913.GA917@daikokuya.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from v035086.ppp.asahi-net.or.jp ([124.155.35.86]:7572 "HELO
	daikokuya.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S2993198AbXEBN7K (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 2 May 2007 09:59:10 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

I have a small and woefully incomplete conformance testsuite (C90
and C99), compile-time logic only, that I've been gradually building
up.  I'm keeping it to myself for now.  I thought I'd run sparse on it.
It has both positive and negative tests, i.e., things that should be
accepted are compiled successfully, and things that should be diagnosed
are diagnosed.

Of course, I realise sparse isn't really intended to be a conforming
compiler and AFAIK you can't even switch between C90 and C99.  As
such I had difficulty finding appropriate switches; I chose to run
"sparse" with -W and -Wall with anything sent to stderr indicating
a diagnostic.  Let me know if something is more appropriate.

Anyway, under these admittedly poor conditions for C90, sparse
failed 47 of 959 tests, which isn't bad.  Some of these will be
logical duplicates (i.e. testing essentially the same thing in
different circumstances; if the thing being tested isn't implemented
at all it'll fail several tests).  For comparison GCC fails 5 of
them.

Here are some failures regarding array declarators that
someone may be interested in.  All should be diagnosed but are not.

extern int a[2][];

struct b
{
  struct b c[2];
};

int c[-1];

Neil.
