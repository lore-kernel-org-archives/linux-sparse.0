From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 3/4] Add support for __builtin_strpbrk()
Date: Fri, 03 Nov 2006 17:17:11 -0500
Message-ID: <20061103221711.7811.33798.stgit@dv.roinet.com>
References: <20061103221659.7811.73832.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from static-72-92-88-10.phlapa.fios.verizon.net ([72.92.88.10]:64905
	"EHLO smtp.roinet.com") by vger.kernel.org with ESMTP
	id S1753559AbWKCWRN (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 3 Nov 2006 17:17:13 -0500
Received: from dv.roinet.com (192.168.1.21 [192.168.1.21])
    by smtp.roinet.com with SMTP;
    for linux-sparse@vger.kernel.org;
    Fri, 03 Nov 2006 17:17:12 -0500 (EST)
    (envelope-from proski@gnu.org)
In-Reply-To: <20061103221659.7811.73832.stgit@dv.roinet.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

From: Pavel Roskin <proski@gnu.org>

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 lib.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/lib.c b/lib.c
index 81e756d..3f753f0 100644
--- a/lib.c
+++ b/lib.c
@@ -479,6 +479,7 @@ void declare_builtin_functions(void)
 	add_pre_buffer("extern char *__builtin_strncpy(char *, const char *, __SIZE_TYPE__);\n");
 	add_pre_buffer("extern __SIZE_TYPE__ __builtin_strspn(const char *, const char *);\n");
 	add_pre_buffer("extern __SIZE_TYPE__ __builtin_strcspn(const char *, const char *);\n");
+	add_pre_buffer("extern char * __builtin_strpbrk(const char *, const char *);\n");
 
 	/* And some random ones.. */
 	add_pre_buffer("extern void *__builtin_return_address(unsigned int);\n");
