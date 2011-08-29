From: Christopher Li <sparse@chrisli.org>
Subject: Sparse 0.4.4-rc2
Date: Mon, 29 Aug 2011 03:20:17 -0700
Message-ID: <4E5B67E1.80902@chrisli.org>
Reply-To: sparse@chrisli.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:40441 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459Ab1H2KUd (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 29 Aug 2011 06:20:33 -0400
Received: by pzk37 with SMTP id 37so8221251pzk.1
        for <linux-sparse@vger.kernel.org>; Mon, 29 Aug 2011 03:20:33 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sparse Mailing-list <linux-sparse@vger.kernel.org>

Another week, another -rc.

It only has a small number of bug fix and enhancement
since the last rc, just the way I like it.
The finial release should be pretty close now.

Pekka Engerg announced an effort of adding llvm
to sparse back end. I am looking forward to merge
it after the finial release.

Chris

--

Christopher Li (3):
       Add test case for empty asm clobbers
       Fix parsing empty asm clobber
       Sparse 0.4.4-rc2

Jonathan Neusch=E4fer (2):
       FAQ: fix a typo ("because or")
       fix common misspellings with codespell

Kamil Dudka (2):
       cse: treat PHI-nodes as other instructions
       cse: update PHI users when throwing away an instruction

Linus Torvalds (3):
       Make 'linearize_iterator()' helper function
       Make 'linearize_switch()' helper function
       Make 'linearize_return()' helper function

Michael Stefaniuc (1):
       Ignore the ms_hook_prologue attribute.

Pekka Enberg (3):
       sparse: Enable unhandled validation tests
       Show expected vs. actual output on test failure
       sparse: Fix __builtin_safe_p for pure and const functions


--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
