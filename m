From: Jari Aalto <jari.aalto@cante.net>
Subject: Cygwin compile error:  No rule to make target `compat-Windows_NT.o', needed by `libsparse.a
Date: Fri, 26 Oct 2007 15:09:24 +0300
Message-ID: <zly6dqmj.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:46096 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752267AbXJZNuF (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 26 Oct 2007 09:50:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IlPZa-0003oC-4m
	for linux-sparse@vger.kernel.org; Fri, 26 Oct 2007 13:50:02 +0000
Received: from a91-155-177-132.elisa-laajakaista.fi ([91.155.177.132])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-sparse@vger.kernel.org>; Fri, 26 Oct 2007 13:50:02 +0000
Received: from jari.aalto by a91-155-177-132.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-sparse@vger.kernel.org>; Fri, 26 Oct 2007 13:50:02 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


git checkout and "make" gives following results in Cygwin. There is no
"INSTALL" file that would explain how the compilation should be
arranged. Please advice.

Jari


     CC       test-lexing.o
     CC       target.o
     CC       parse.o
parse.c:367: warning: `__sentinel__' attribute directive ignored
parse.c: In function `apply_modifiers':
parse.c:407: warning: enumeration value `SYM_UNINITIALIZED' not handled in switch
parse.c:407: warning: enumeration value `SYM_PREPROCESSOR' not handled in switch
parse.c:407: warning: enumeration value `SYM_BASETYPE' not handled in switch
parse.c:407: warning: enumeration value `SYM_NODE' not handled in switch
parse.c:407: warning: enumeration value `SYM_STRUCT' not handled in switch
parse.c:407: warning: enumeration value `SYM_UNION' not handled in switch
parse.c:407: warning: enumeration value `SYM_TYPEDEF' not handled in switch
parse.c:407: warning: enumeration value `SYM_TYPEOF' not handled in switch
parse.c:407: warning: enumeration value `SYM_MEMBER' not handled in switch
parse.c:407: warning: enumeration value `SYM_LABEL' not handled in switch
parse.c:407: warning: enumeration value `SYM_RESTRICT' not handled in switch
parse.c:407: warning: enumeration value `SYM_FOULED' not handled in switch
parse.c:407: warning: enumeration value `SYM_KEYWORD' not handled in switch
parse.c:407: warning: enumeration value `SYM_BAD' not handled in switch
     CC       tokenize.o
     GEN      pre-process.h
     CC       pre-process.o
     CC       symbol.o
     CC       lib.o
     CC       scope.o
     CC       expression.o
     CC       show-parse.o
     CC       evaluate.o
     CC       expand.o
     CC       inline.o
     CC       linearize.o
     CC       sort.o
     CC       allocate.o
make: *** No rule to make target `compat-Windows_NT.o', needed by `libsparse.a'.  Stop.

-- 
Welcome to FOSS revolution: we fix and modify until it shines
