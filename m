From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: random line shuffling test
Date: Sun, 29 Jul 2007 15:33:20 +0400
Message-ID: <20070729113320.GA5784@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:38880 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761416AbXG2LdZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 29 Jul 2007 07:33:25 -0400
Received: by nf-out-0910.google.com with SMTP id g13so113065nfb
        for <linux-sparse@vger.kernel.org>; Sun, 29 Jul 2007 04:33:23 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

I'm currently running random line shuffling test taking, ha-ha, advansys.i
as input.

Here is first trimmed testcase on which valgrind says stack overflow and
sparse segfaults.


int a, struct b c);
typedef void (elevator_activate_req_fn)(foo *);
typedef void (elevator_activate_req_fn)(struct foo *);
struct sigaction {
static struct lock_class_key __key;



So far the joy is spoiled by many infinite loops sparse gets into and
automatic testing is still semi-automatic, but stay tuned.
