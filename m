From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: segfault on switch() + bitwise combo
Date: Fri, 9 Jun 2006 19:17:43 +0400
Message-ID: <20060609151742.GA21428@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:50669 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965188AbWFIPR0 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 9 Jun 2006 11:17:26 -0400
Received: by nf-out-0910.google.com with SMTP id x4so575829nfb
        for <linux-sparse@vger.kernel.org>; Fri, 09 Jun 2006 08:17:25 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Morten Welinder <terra@gnome.org>

It triggers by checking with -Wbitwise on drivers/net/wireless/ipw2100.c
and net/sctp/sm_make_chunk.c

Reduced testcase:
-----------------------------------------------------
     1	typedef int __attribute__((bitwise)) A;
     2	
     3	void f(A a)
     4	{
     5		switch (a & 1) {
     6		case 0:
     7			break;
     8		}
     9	}

$ sparse -Wbitwise 1.c
1.c:5:12: error: incompatible types for operation (&)
Segmentation fault
-----------------------------------------------------
Recently added is_enum_type() call at evaluate.c:2670 gets NULL pointer.
