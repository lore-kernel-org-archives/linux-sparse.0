From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/5] add instruction OP_UNREACH
Date: Wed, 18 Mar 2020 18:31:17 +0100
Message-ID: <20200318173120.63939-3-luc.vanoostenryck@gmail.com>
References: <20200318173120.63939-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr1-f46.google.com ([209.85.221.46]:43778 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgCRRb1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 18 Mar 2020 13:31:27 -0400
Received: by mail-wr1-f46.google.com with SMTP id b2so25252179wrj.10
        for <linux-sparse@vger.kernel.org>; Wed, 18 Mar 2020 10:31:26 -0700 (PDT)
In-Reply-To: <20200318173120.63939-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/IR.rst | 3 +++
 linearize.c          | 3 +++
 opcode.def           | 1 +
 3 files changed, 7 insertions(+)

diff --git a/Documentation/IR.rst b/Documentation/IR.rst
index 9d6f2299eaf1..33a761662fad 100644
--- a/Documentation/IR.rst
+++ b/Documentation/IR.rst
@@ -47,6 +47,9 @@ Terminators
 	* .type: type of .cond, must be an integral type
 	* .multijmp_list: pairs of case-value - destination basic block
 
+.. op:: OP_UNREACH
+	Mark code as unreachable
+
 .. op:: OP_COMPUTEDGOTO
 	Computed goto / branch to register
 
diff --git a/linearize.c b/linearize.c
index 30ed2a302d95..f1e538e23ae1 100644
--- a/linearize.c
+++ b/linearize.c
@@ -183,6 +183,7 @@ static const char *opcodes[] = {
 	[OP_BR] = "br",
 	[OP_CBR] = "cbr",
 	[OP_SWITCH] = "switch",
+	[OP_UNREACH] = "unreach",
 	[OP_COMPUTEDGOTO] = "jmp *",
 	
 	/* Binary */
@@ -399,6 +400,8 @@ const char *show_instruction(struct instruction *insn)
 		} END_FOR_EACH_PTR(jmp);
 		break;
 	}
+	case OP_UNREACH:
+		break;
 
 	case OP_PHISOURCE: {
 		struct instruction *phi;
diff --git a/opcode.def b/opcode.def
index 57d827f449b5..2583e2f4a602 100644
--- a/opcode.def
+++ b/opcode.def
@@ -10,6 +10,7 @@ OPCODE(RET,             BADOP,    BADOP,    BADOP, 1, OPF_NONE)
 OPCODE(BR,              BADOP,    BADOP,    BADOP, 0, OPF_NONE)
 OPCODE(CBR,             BADOP,    BADOP,    BADOP, 1, OPF_NONE)
 OPCODE(SWITCH,          BADOP,    BADOP,    BADOP, 1, OPF_NONE)
+OPCODE(UNREACH,         BADOP,    BADOP,    BADOP, 0, OPF_NONE)
 OPCODE(COMPUTEDGOTO,    BADOP,    BADOP,    BADOP, 1, OPF_NONE)
 OPCODE_RANGE(TERMINATOR, RET, COMPUTEDGOTO)
 
-- 
2.25.1
