From: behanw@converseincode.com
Subject: [PATCH 2/5] kbuild: LLVMLinux: Adapt warnings for compilation with clang
Date: Tue, 25 Feb 2014 17:08:40 -0800
Message-ID: <1393376923-21892-3-git-send-email-behanw@converseincode.com>
References: <1393376923-21892-1-git-send-email-behanw@converseincode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:53216 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914AbaBZBJa (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 25 Feb 2014 20:09:30 -0500
Received: by mail-pb0-f50.google.com with SMTP id md12so221667pbc.9
        for <linux-sparse@vger.kernel.org>; Tue, 25 Feb 2014 17:09:30 -0800 (PST)
In-Reply-To: <1393376923-21892-1-git-send-email-behanw@converseincode.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: mmarek@suse.cz, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, sparse@chrisli.org
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org, torvalds@linux-foundation.org, dwmw2@infradead.org, pageexec@freemail.hu, =?UTF-8?q?Jan-Simon=20M=C3=B6ller?= <dl9pf@gmx.de>, Behan Webster <behanw@converseincode.com>, Mark Charlebois <mcharleb@gmail.com>

=46rom: Jan-Simon M=C3=B6ller <dl9pf@gmx.de>

When compiling kernel with clang, disable warnings which are too noisy,=
 and
add the clang flag catch-undefined-behavior.

Signed-off-by: Jan-Simon M=C3=B6ller <dl9pf@gmx.de>
Signed-off-by: Behan Webster <behanw@converseincode.com>
Signed-off-by: Mark Charlebois <mcharleb@gmail.com>
Cc: PaX Team <pageexec@freemail.hu>
---
 scripts/Makefile.build | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index d5d859c..27c4098 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -65,12 +65,23 @@ warning-  :=3D $(empty)
 warning-1 :=3D -Wextra -Wunused -Wno-unused-parameter
 warning-1 +=3D -Wmissing-declarations
 warning-1 +=3D -Wmissing-format-attribute
-warning-1 +=3D -Wmissing-prototypes
+warning-1 +=3D $(call cc-option, -Wmissing-prototypes)
 warning-1 +=3D -Wold-style-definition
 warning-1 +=3D $(call cc-option, -Wmissing-include-dirs)
 warning-1 +=3D $(call cc-option, -Wunused-but-set-variable)
 warning-1 +=3D $(call cc-disable-warning, missing-field-initializers)
=20
+# Clang
+warning-1 +=3D $(call cc-disable-warning, initializer-overrides)
+warning-1 +=3D $(call cc-disable-warning, unused-value)
+warning-1 +=3D $(call cc-disable-warning, format)
+warning-1 +=3D $(call cc-disable-warning, unknown-warning-option)
+warning-1 +=3D $(call cc-disable-warning, self-assign)
+warning-1 +=3D $(call cc-disable-warning, sign-compare)
+warning-1 +=3D $(call cc-disable-warning, format-zero-length)
+warning-1 +=3D $(call cc-disable-warning, uninitialized)
+warning-1 +=3D $(call cc-option, -fcatch-undefined-behavior)
+
 warning-2 :=3D -Waggregate-return
 warning-2 +=3D -Wcast-align
 warning-2 +=3D -Wdisabled-optimization
--=20
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
