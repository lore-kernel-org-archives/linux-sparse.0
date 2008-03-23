From: "Codrin Alexandru Grajdeanu" <grcodal@gmail.com>
Subject: Interrupt context
Date: Sun, 23 Mar 2008 23:44:56 +0200
Message-ID: <3581ed890803231444i58cff10i408dc4d9bef7b184@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:33427 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754025AbYCWVo6 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 23 Mar 2008 17:44:58 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2632083fgb.17
        for <linux-sparse@vger.kernel.org>; Sun, 23 Mar 2008 14:44:56 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Octavian Purdila <tavi@cs.pub.ro>

Hi all,

 I am a student from Politehnica University of Bucharest studying
 Computer Science. I would like to add some new kernel source checks
 based on sparse. The first idea would be to test if from interrupt
 context sleepy functions are called.
 To test this, sparse would be required to run twice. First to get all
 interrupt context functions, by verifying what arguments are passed to
 irq_handler_t() and what values are passed to the function pointers in
 struct timer_list, softirq_action and tasklet_struct. The second run
 would generate the call graph for this function and would verify if
 schedule() is called inside their call graph.
 What do you think about this?

 Thank you,
 Codrin Grajdenau
