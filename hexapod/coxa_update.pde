public class CoxaUpdate 
{
   boolean _modified;
   float _newAngle;

  public CoxaUpdate(boolean modified, float newAngle)
  {
    _modified = modified;
    _newAngle = newAngle;
  }

   boolean Modified() 
   {
     return _modified;
   }

   float NewAngle() 
   {
     return _newAngle;
   }
}
