From: Alexey Dobriyan <adobriyan@sw.ru>
Subject: segfaults in pathological cases from gcc testsuite
Date: Mon, 22 Oct 2007 19:24:59 +0400
Message-ID: <20071022152459.GE6271@localhost.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mailhub.sw.ru ([195.214.233.200]:46834 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751530AbXJVPZJ (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Oct 2007 11:25:09 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: adobriyan@gmail.com

FWIW, I fed full gcc tree to sparse not only testsuite. Suprisingly it
crashed only in two places:


--------------------------------------------------------
gcc/testsuite/gcc.c-torture/compile/limits-exprparen.c

#define LBR1 ( ( ( ( ( ( ( ( ( (
#define LBR2 LBR1 LBR1 LBR1 LBR1 LBR1 LBR1 LBR1 LBR1 LBR1 LBR1
#define LBR3 LBR2 LBR2 LBR2 LBR2 LBR2 LBR2 LBR2 LBR2 LBR2 LBR2
#define LBR4 LBR3 LBR3 LBR3 LBR3 LBR3 LBR3 LBR3 LBR3 LBR3 LBR3
#define LBR5 LBR4 LBR4 LBR4 LBR4 LBR4 LBR4 LBR4 LBR4 LBR4 LBR4
#define LBR6 LBR5 LBR5 LBR5 LBR5 LBR5 LBR5 LBR5 LBR5 LBR5 LBR5

#define RBR1 ) ) ) ) ) ) ) ) ) )
#define RBR2 RBR1 RBR1 RBR1 RBR1 RBR1 RBR1 RBR1 RBR1 RBR1 RBR1
#define RBR3 RBR2 RBR2 RBR2 RBR2 RBR2 RBR2 RBR2 RBR2 RBR2 RBR2
#define RBR4 RBR3 RBR3 RBR3 RBR3 RBR3 RBR3 RBR3 RBR3 RBR3 RBR3
#define RBR5 RBR4 RBR4 RBR4 RBR4 RBR4 RBR4 RBR4 RBR4 RBR4 RBR4
#define RBR6 RBR5 RBR5 RBR5 RBR5 RBR5 RBR5 RBR5 RBR5 RBR5 RBR5

int q5_var = LBR4 0 RBR4;
--------------------------------------------------------
gcc/testsuite/gcc.c-torture/compile/limits-caselabels.c

#define LIM1(x) x##0: x##1: x##2: x##3: x##4: x##5: x##6: x##7: x##8: x##9: 
#define LIM2(x) LIM1(x##0) LIM1(x##1) LIM1(x##2) LIM1(x##3) LIM1(x##4) \
		LIM1(x##5) LIM1(x##6) LIM1(x##7) LIM1(x##8) LIM1(x##9)
#define LIM3(x) LIM2(x##0) LIM2(x##1) LIM2(x##2) LIM2(x##3) LIM2(x##4) \
		LIM2(x##5) LIM2(x##6) LIM2(x##7) LIM2(x##8) LIM2(x##9)
#define LIM4(x) LIM3(x##0) LIM3(x##1) LIM3(x##2) LIM3(x##3) LIM3(x##4) \
		LIM3(x##5) LIM3(x##6) LIM3(x##7) LIM3(x##8) LIM3(x##9)
#define LIM5(x) LIM4(x##0) LIM4(x##1) LIM4(x##2) LIM4(x##3) LIM4(x##4) \
		LIM4(x##5) LIM4(x##6) LIM4(x##7) LIM4(x##8) LIM4(x##9)
#define LIM6(x) LIM5(x##0) LIM5(x##1) LIM5(x##2) LIM5(x##3) LIM5(x##4) \
		LIM5(x##5) LIM5(x##6) LIM5(x##7) LIM5(x##8) LIM5(x##9)
#define LIM7(x) LIM6(x##0) LIM6(x##1) LIM6(x##2) LIM6(x##3) LIM6(x##4) \
		LIM6(x##5) LIM6(x##6) LIM6(x##7) LIM6(x##8) LIM6(x##9)

void q19_func (long i)
{
  switch (i) {
    LIM5 (case 1)
      break;
  }
}
--------------------------------------------------------
