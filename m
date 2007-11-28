From: nkavv@physics.auth.gr
Subject: Backend projects for Sparse
Date: Wed, 28 Nov 2007 11:53:00 +0200
Message-ID: <1196243580.474d3a7c9895b@mail.physics.auth.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sisifos.physics.auth.gr ([155.207.123.6]:64966 "EHLO
	physics.auth.gr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756236AbXK1J7j (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 28 Nov 2007 04:59:39 -0500
Received: from srv003.physics.auth.gr (HELO localhost) ([10.206.123.203])
          (envelope-sender <nkavv@physics.auth.gr>)
          by physics.auth.gr (qmail-ldap-1.03) with SMTP
          for <linux-sparse@vger.kernel.org>; 28 Nov 2007 09:53:00 -0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi all

i came across Sparse a few months ago and looks really interesting. Now, I have
a few questions regarding the sparse infrastructure:

1) Regarding the intermediate representation dumps that can be generated (via
"test-linearize" i think). Do you support canonical SSA form (as defined in the
classical books/papers)?

2) Is it possible to generate a self-contained IR dump, so that it could be
possible to feed it to external (third-party) code selectors?
In my mind a single C program file (actually read: translation unit) would be
translated to something like the following structure:

struct CTranslationUnit {
  struct GlobalVars; // is a List of global variables (scalars, arrays etc)
  struct ProcedureList;
}

struct ProcedureList
{
  struct LocalVars;  // local variable list
  List   ThreeAddressCodeInstr; // three-address code operations (4-tuples)
}

There a couple of frontends that can do this (the proprietary/no cost for
research only LANCE compiler frontend).

3) What does the c2xml backend exactly do?

4) Is there anyone working on a RISC-like processor backend project. I feel that
 if the entire backend can be contained in something like "compile-i386.c" then
it could be even possible to automate the generation of such file from a more
compact specification file. (plus some hand-written intrinsics probably).

5) Is there any documentation covering the API and linked tools to the sparse
library (something more than the man pages)?

6) Sparse looks good. I like the IR dumps a lot. That's a comment ^_^

Kind regards,
Nikolaos Kavvadias
