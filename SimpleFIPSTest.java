import org.bouncycastle.crypto.fips.FipsStatus;
import org.bouncycastle.crypto.CryptoServicesRegistrar;

public class SimpleFIPSTest {
    public static void main(String[] args) {
        if (!FipsStatus.isReady()) {
            System.err.println("FIPS status is not ready");
            System.exit(1);
        }

        System.out.println("FIPS status of BCFIPS is ready");
        
        boolean isApprovedOnly = CryptoServicesRegistrar.isInApprovedOnlyMode();
        if (isApprovedOnly) {
            System.out.println("Bouncy Castle is in approved-only mode.");
        } else {
            System.out.println("Bouncy Castle is not in approved-only mode.");
        }
    }
}
