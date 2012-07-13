From: Ben Pfaff <blp@nicira.com>
Subject: comparisons yield bool instead of int?
Date: Fri, 13 Jul 2012 14:49:32 -0700
Message-ID: <20120713214932.GJ31844@nicira.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:50217 "HELO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751742Ab2GMVtj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 13 Jul 2012 17:49:39 -0400
Received: by ghbz22 with SMTP id z22so5804452ghb.27
        for <linux-sparse@vger.kernel.org>; Fri, 13 Jul 2012 14:49:37 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

The C standard says that equality operators yield "int", but sparse
thinks that they yield "bool":

    blp@sigsegv:~/sparse$ cat test.c
    static void f(void)
    {
       sizeof(1 == 2);
    }
    blp@sigsegv:~/sparse$ ./sparse test.c
    test.c:3:4: warning: expression using sizeof bool
    blp@sigsegv:~/sparse$ git rev-parse HEAD
    970d7169d75068146152ba01a66381c800dbeb71

Thanks,

Ben.
